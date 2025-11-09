import { Entity, PrimaryColumn } from 'typeorm';
import { AbstractEntity } from './abstract.entity';

@Entity('email_attachments')
export class EmailAttachments extends AbstractEntity {
  @PrimaryColumn({ type: 'int' })
  email_id: number;

  @PrimaryColumn({ type: 'int' })
  media_id: number;
}
