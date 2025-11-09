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

  @Column({ type: 'char', length: 64, unique: true, nullable: false })
  token: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  password_hash: string;

  @Column({ type: 'int', nullable: true })
  receiver_id: number;

  @Column({ type: 'timestamp', nullable: true })
  expires_at: Date;
}
