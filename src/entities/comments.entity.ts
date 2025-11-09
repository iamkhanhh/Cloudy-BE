import { Entity, Column, Index } from 'typeorm';
import { AbstractEntity } from './abstract.entity';

@Entity('comments')
export class Comments extends AbstractEntity {
  @Column({ type: 'int', nullable: false })
  media_id: number;

  @Column({ type: 'int', nullable: false })
  author_id: number;

  @Column({ type: 'text', nullable: false })
  content: string;
}
