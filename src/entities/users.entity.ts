import { UserStatusEnum } from '@/enums';
import { Entity, Column, Index } from 'typeorm';
import { AbstractEntity } from './abstract.entity';
import { UserRoleEnum } from '@/enums/user-role.enum';

@Entity('users')
export class Users extends AbstractEntity {
  @Column({ type: 'varchar', length: 255, unique: true, nullable: false })
  email: string;

  @Column({ type: 'varchar', length: 255, nullable: false })
  password: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  first_name: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  last_name: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  phone_number: string;

  @Column({ type: 'text', nullable: true })
  bio: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  avatar_path: string;

  @Column({
    type: 'enum',
    enum: UserStatusEnum,
    default: UserStatusEnum.PENDING,
    nullable: false,
  })
  status: UserStatusEnum;

  @Column({
    type: 'enum',
    enum: UserRoleEnum,
    default: UserRoleEnum.USER,
    nullable: false,
  })
  role: UserRoleEnum;

  @Column()
  codeId: string;

  @Column({ type: 'timestamp', nullable: true })
  codeExpired: Date;
}