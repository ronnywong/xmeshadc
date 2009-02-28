/*
 * Copyright (c) 2002-2005 Intel Corporation
 * Copyright (c) 2000-2005 The Regents of the University of California
 * All rights reserved.
 * See license.txt file included with the distribution.
 *
 * $Id: sched.c,v 1.1.4.1 2007/04/27 06:06:03 njain Exp $
 */


/*
 *
 * Authors:		Jason Hill, Philip Levis
 * Revision:		$Id: sched.c,v 1.1.4.1 2007/04/27 06:06:03 njain Exp $
 * Modifications:       Removed unecessary code, cleanup.(5/30/02)
 *
 *                      Moved from non-blocking list to simple
 *                      critical section.  Changed task queue to
 *                      length 8 (more efficient). (3/10/02)
 */




/*
 * Scheduling data structures
 *
 * There is a list of size MAX_TASKS, stored as an cyclic array buffer.
 * TOSH_sched_full is the index of first used slot (head of list).
 * TOSH_sched_free is the index of first free slot (after tail of list).
 * If free equals full, the list is empty.
 * The list keeps at least one empty slot; one cannot add a task if
 * advancing free would make it equal to full.
 *
 * Each entry consists of a task function pointer.
 *
 */

typedef struct {
  void (*tp) ();
} TOSH_sched_entry_T;

enum {
#ifdef TOSH_MAX_TASKS_LOG2
#if TOSH_MAX_TASKS_LOG2 > 8
#error "Maximum of 256 tasks, TOSH_MAX_TASKS_LOG2 must be <= 8"
#endif
  TOSH_MAX_TASKS = 1 << TOSH_MAX_TASKS_LOG2,
#else
  TOSH_MAX_TASKS = 32,
#endif
  TOSH_TASK_BITMASK = (TOSH_MAX_TASKS - 1)
};

volatile TOSH_sched_entry_T TOSH_queue[TOSH_MAX_TASKS];
uint8_t TOSH_sched_full;
volatile uint8_t TOSH_sched_free;

void TOSH_sched_init(void)
{
  int i;
  TOSH_sched_free = 0;
  TOSH_sched_full = 0;
  for (i = 0; i < TOSH_MAX_TASKS; i++)
    TOSH_queue[i].tp = NULL;
}

bool TOS_post(void (*tp) ());

#ifndef NESC_BUILD_BINARY

/*
 * TOS_post (thread_pointer)
 *  
 * Put the task pointer into the next free slot.
 * Return 1 if successful, 0 if there is no free slot.
 *
 * This function uses a critical section to protect TOSH_sched_free.
 * As tasks can be posted in both interrupt and non-interrupt context,
 * this is necessary.
 */
bool TOS_post(void (*tp) ()) __attribute__((spontaneous)) {
  __nesc_atomic_t fInterruptFlags;
  uint8_t tmp;

  //  dbg(DBG_SCHED, ("TOSH_post: %d 0x%x\n", TOSH_sched_free, (int)tp));
  
  fInterruptFlags = __nesc_atomic_start();

  tmp = TOSH_sched_free;
  
  if (TOSH_queue[tmp].tp == NULL) {
    TOSH_sched_free = (tmp + 1) & TOSH_TASK_BITMASK;
    TOSH_queue[tmp].tp = tp;
    __nesc_atomic_end(fInterruptFlags);

    return TRUE;
  }
  else {	
    __nesc_atomic_end(fInterruptFlags);

    return FALSE;
  }
}

#endif

/*
 * TOSH_schedule_task()
 *
 * Remove the task at the head of the queue and execute it, freeing
 * the queue entry. Return 1 if a task was executed, 0 if the queue
 * is empty.
 */

bool TOSH_run_next_task ()
{
  __nesc_atomic_t fInterruptFlags;
  uint8_t old_full;
  void (*func)(void);
  
  fInterruptFlags = __nesc_atomic_start();
  old_full = TOSH_sched_full;
  func = TOSH_queue[old_full].tp;
  if (func == NULL)
    {
      __nesc_atomic_sleep();
      return 0;
    }

  TOSH_queue[old_full].tp = NULL;
  TOSH_sched_full = (old_full + 1) & TOSH_TASK_BITMASK;
  __nesc_atomic_end(fInterruptFlags);
  func();

  return 1;
}

void TOSH_run_task() {
  for (;;)
    TOSH_run_next_task();
}
