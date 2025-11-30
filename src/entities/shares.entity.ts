import { SharePermissionEnum } from '@/enums';
import { Entity, Column, Index } from 'typeorm';
import { AbstractEntity } from './abstract.entity';

@Entity('shares')
export class Shares extends AbstractEntity {
  @Column({ type: 'varchar', length: 32, nullable: false })
  resource_type: string;

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

  @Column({ type: 'varchar', length: 255, nullable: true })
  password_hash: string;

  @Column({ type: 'varchar', nullable: true })
  receiver_id: string;

  @Column({ type: 'timestamp', nullable: true })
  expires_at: Date;
}
