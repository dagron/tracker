<?php

namespace App\Dto\ApiResponse;

use Symfony\Component\Serializer\Annotation\Groups;

/**
 * Class TaskDto.
 */
class TaskDto
{
    /**
     * @var int
     *
     * @Groups({"api"})
     */
    public $id;

    /**
     * @var string
     *
     * @Groups({"api"})
     */
    public $name;

    /**
     * @var string
     *
     * @Groups({"api"})
     */
    public $state;

    /**
     * @var \DateTime
     *
     * @Groups({"api"})
     */
    public $start;

    /**
     * @var \DateTime|null
     *
     * @Groups({"api"})
     */
    public $end = null;

    /**
     * @var string|null
     *
     * @Groups({"api"})
     */
    public $repeatType = null;

    /**
     * @var int[]|null
     *
     * @Groups({"api"})
     */
    public $repeatValue = null;

    /**
     * @var \DateTime
     *
     * @Groups({"api"})
     */
    public $forDate;

    /**
     * @var array
     *
     * @Groups({"api"})
     */
    public $transfers = [];

    /**
     * @var bool
     *
     * todo: Наверное стоит удалить
     */
    public $isTransferred = false;

    /**
     * @var int|null
     *
     * @Groups({"api"})
     */
    public $position = null;
}
