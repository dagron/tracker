<?php

namespace App\Request\Task;

use App\Http\RequestDtoInterface;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * Class ChangeTaskPositionRequest.
 */
class ChangeTaskPositionRequest implements RequestDtoInterface
{
    /**
     * @var \DateTime
     *
     * @Assert\NotNull
     * @Assert\NotBlank
     * @Assert\Date
     */
    public $forDate;

    /**
     * @var int
     *
     * @Assert\NotNull
     * @Assert\NotBlank
     */
    public $position;
}
