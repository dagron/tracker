<?php

namespace App\Service\Task;

use App\Doctrine\DBAL\Type\TaskChangeStateType;
use App\Dto\ApiResponse\TaskDto;
use App\Entity\Task;
use Symfony\Component\Security\Core\Authentication\Token\Storage\TokenStorageInterface;

/**
 * Class DtoService.
 */
class DtoService
{
    /**
     * @var TokenStorageInterface
     */
    private $tokenStorage;

    /**
     * DtoService constructor.
     *
     * @param TokenStorageInterface $tokenStorage
     */
    public function __construct(TokenStorageInterface $tokenStorage)
    {
        $this->tokenStorage = $tokenStorage;
    }

    /**
     * @param Task           $task
     * @param \DateTime      $forDate
     * @param \DateTime|null $start
     *
     * @return TaskDto
     */
    public function create(Task $task, \DateTime $forDate, \DateTime $start = null): TaskDto
    {
        $dto = new TaskDto();
        $dto->id = $task->getId();
        $dto->name = $task->getName();
        $dto->start = $task->getStartDate();
        $dto->end = !is_null($task->getEndDate()) ? $task->getEndDate() : null;
        $dto->forDate = $forDate;
        $dto->repeatType = $task->getRepeatType();
        $dto->repeatValue = $task->getRepeatValue();
        $dto->state = TaskChangeStateType::IN_PROGRESS;

        foreach ($task->getTransfers() as $transfer) {
            if ($transfer->getForDate() == $forDate) {
                $dto->transfers[] = $transfer->getTransferTo();
            }
        }

        foreach ($task->getChanges() as $change) {
            if ($change->getForDate() != $forDate) {
                continue;
            }

            if (!is_null($change->getState())) {
                $dto->state = $change->getState();
            }

            if (!is_null($change->getPosition())) {
                $dto->position = $change->getPosition();
            }
        }

        return $dto;
    }
}
