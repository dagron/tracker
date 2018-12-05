<?php

namespace App\Service\Task;

use App\Entity\Task;

/**
 * Class TaskScheduleService.
 */
class TaskScheduleService
{
    /**
     * @param Task      $task
     * @param \DateTime $date
     *
     * @return bool
     */
    public function isTaskScheduled(Task $task, \DateTime $date): bool
    {
        // Отсекает неподходящие по дате задачи (вдруг из репозитория получим неправильный набор задач?).
        if ($task->getStartDate() > $date || (!is_null($task->getEndDate()) && $task->getEndDate() < $date)) {
            return false;
        }

        if (is_null($task->getSchedule())) {
            return $date == $task->getStartDate();
        }

        $daysDiff = (int) date_diff($date, $task->getStartDate())->format('%a');
        $scheduleArraySize = count($task->getSchedule());

        if (0 === $daysDiff) {
            $i = 0;
        } elseif ($daysDiff < $scheduleArraySize) {
            $i = $daysDiff;
        } else {
            $i = $daysDiff % $scheduleArraySize;
        }

        return 1 === $task->getSchedule()[$i];
    }
}
