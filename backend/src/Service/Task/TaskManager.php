<?php

namespace App\Service\Task;

use App\Entity\Task;
use Doctrine\ORM\EntityManagerInterface;

/**
 * Class TaskManager.
 */
class TaskManager implements TaskManagerInterface
{
    /**
     * @var EntityManagerInterface
     */
    private $em;

    /**
     * TaskManager constructor.
     *
     * @param EntityManagerInterface $em
     */
    public function __construct(EntityManagerInterface $em)
    {
        $this->em = $em;
    }

    /**
     * {@inheritdoc}
     */
    public function add(string $name): Task
    {
        $task = new Task();
        $task->setName($name);
        $task->setPosition(0);

        $this->em->persist($task);

        $this->em->flush();

        return $task;
    }

    /**
     * {@inheritdoc}
     *
     * todo: когда удаляем несколько элементов из середины списка, у некоторых элементов позиция не обновляется
     */
    public function remove(array $ids)
    {
        $tasks = $this->em->getRepository(Task::class)->findBy([
            'id' => $ids,
        ]);

        foreach ($tasks as $task) {
            $this->em->remove($task);
        }

        $this->em->flush();
    }

    /**
     * {@inheritdoc}
     */
    public function rename(Task $task, string $name): Task
    {
        $task->setName($name);

        $this->em->persist($task);

        $this->em->flush();

        return $task;
    }

    /**
     * {@inheritdoc}
     */
    public function move(Task $task, int $position): Task
    {
        $task->setPosition($position);

        $this->em->persist($task);

        $this->em->flush();

        return $task;
    }
}
