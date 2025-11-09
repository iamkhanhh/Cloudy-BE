import { VisibilityEnum } from '@/enums';
import { Entity, Column, Index } from 'typeorm';
import { AbstractEntity } from './abstract.entity';

@Entity('albums')
export class Albums extends AbstractEntity {
  @Column({ type: 'int', nullable: false })
  owner_id: number;

  @Column({ type: 'varchar', length: 255, nullable: false })
  name: string;

  @Column({ type: 'text', nullable: true })
  description: string;

  @Column({ type: 'int', nullable: true })
  cover_media_id: number;

  @Column({
    type: 'enum',
    enum: VisibilityEnum,
    default: VisibilityEnum.PRIVATE,
    nullable: false,
  })
  visibility: VisibilityEnum;
}
