<?php

namespace Task\Service;

use Task\Entity\Task;
use Task\Entity\TaskChange;
use Task\Repository\TaskChangeRepository;
use Doctrine\ORM\EntityManagerInterface;

/**
 * Class UpdateTaskState.
 */
class UpdateTaskState
{
    /**
     * @var EntityManagerInterface
     */
    private $em;

    /**
     * UpdateTaskState constructor.
     *
     * @param EntityManagerInterface $em
     */
    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
    }

    /**
     * @param Task      $task
     * @param \DateTime $forDate
     * @param string    $state
     *
     * @return TaskChange
     */
    public function update(Task $task, \DateTime $forDate, string $state): TaskChange
    {
        /**
         * @var TaskChangeRepository $taskChangeRepository
         */
        $taskChangeRepository = $this->em->getRepository(TaskChange::class);

        $change = $taskChangeRepository->findOneBy([
            'task' => $task,
            'forDate' => $forDate,
        ]);

        if (!$change) {
            $change = new TaskChange();
            $change->setTask($task);
            $change->setForDate($forDate);
            $change->setState($state);
        } else {
            $change->setState($state);
        }

        $this->em->persist($change);
        $this->em->flush();

        return $change;
    }
}
