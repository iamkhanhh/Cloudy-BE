import { ResourceTypeEnum, SharePermissionEnum } from '@/enums';
import { Entity, Column } from 'typeorm';
import { AbstractEntity } from './abstract.entity';

@Entity('shares')
export class Shares extends AbstractEntity {
  @Column({ type: 'varchar', length: 32, nullable: false,  enum: ResourceTypeEnum, default: ResourceTypeEnum.MEDIA })
  resource_type: ResourceTypeEnum;

  @Column({ type: 'int', nullable: false })
  resource_id: number;

  @Column({ type: 'int', nullable: false })
  owner_id: number;

  @Column({
    type: 'enum',
    enum: SharePermissionEnum,
    default: SharePermissionEnum.VIEW,
    nullable: false,
  })
  permission: SharePermissionEnum;

  @Column({ type: 'int', nullable: true })
  receiver_id: number;
}
