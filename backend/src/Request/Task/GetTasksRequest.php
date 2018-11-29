<?php

namespace App\Request\Task;

use App\Http\RequestDtoInterface;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Class GetTasksRequest.
 */
class GetTasksRequest implements RequestDtoInterface
{
    /**
     * @var \DateTime
     *
     * @Assert\NotNull()
     * @Assert\NotBlank()
     * @Assert\Date()
     */
    public $start;

    /**
     * @var \DateTime
     *
     * @Assert\Date()
     */
    public $end;
}
