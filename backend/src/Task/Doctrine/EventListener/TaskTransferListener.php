<?php

namespace Task\Doctrine\EventListener;

use Task\Entity\TaskTransfer;
use Doctrine\ORM\Mapping as ORM;

/**
 * Class TaskTransferListener.
 */
final class TaskTransferListener
{
    /**
     * @param TaskTransfer $transfer
     *
     * @ORM\PrePersist
     */
    public function prePersist(TaskTransfer $transfer)
    {
        $transfer->setCreatedAt(new \DateTime());
    }
}
