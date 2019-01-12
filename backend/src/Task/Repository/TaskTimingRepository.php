<?php

namespace Task\Repository;

use Task\Entity\TaskTiming;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Symfony\Bridge\Doctrine\RegistryInterface;

/**
 * @method TaskTiming|null find($id, $lockMode = null, $lockVersion = null)
 * @method TaskTiming|null findOneBy(array $criteria, array $orderBy = null)
 * @method TaskTiming[]    findAll()
 * @method TaskTiming[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class TaskTimingRepository extends ServiceEntityRepository
{
    /**
     * TaskTimingRepository constructor.
     *
     * @param RegistryInterface $registry
     */
    public function __construct(RegistryInterface $registry)
    {
        parent::__construct($registry, TaskTiming::class);
    }
}
