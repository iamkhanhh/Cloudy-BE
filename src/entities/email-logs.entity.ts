import { EmailStatusEnum } from '@/enums';
import { Entity, Column, Index } from 'typeorm';
import { AbstractEntity } from './abstract.entity';

@Entity('email_logs')
export class EmailLogs extends AbstractEntity {
  @Column({ type: 'int', nullable: false })
  sender_id: number;

  @Column({ type: 'varchar', length: 255, nullable: false })
  to_email: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  subject: string;

  @Column({ type: 'text', nullable: true })
  body: string;

  @Column({
    type: 'enum',
    enum: EmailStatusEnum,
    default: EmailStatusEnum.QUEUED,
    nullable: false,
  })
  status: EmailStatusEnum;

  @Column({ type: 'text', nullable: true })
  error_message: string;
}
