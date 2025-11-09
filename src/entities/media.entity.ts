import { MediaTypeEnum, VisibilityEnum, ProcessingStatusEnum } from '@/enums';
import { Entity, Column } from 'typeorm';
import { AbstractEntity } from './abstract.entity';

@Entity('media')
export class Media extends AbstractEntity {
  @Column({ type: 'int', nullable: false })
  owner_id: number;

  @Column({
    type: 'enum',
    enum: MediaTypeEnum,
    nullable: false,
  })
  type: MediaTypeEnum;

  @Column({ type: 'varchar', length: 255, nullable: false })
  mime_type: string;

  @Column({ type: 'varchar', length: 512, nullable: false })
  filename: string;

  @Column({ type: 'int', nullable: true })
  size: number;

  @Column({ type: 'int', nullable: true })
  duration_ms: number;

  @Column({
    type: 'enum',
    enum: VisibilityEnum,
    default: VisibilityEnum.PRIVATE,
    nullable: false,
  })
  visibility: VisibilityEnum;

  @Column({
    type: 'enum',
    enum: ProcessingStatusEnum,
    default: ProcessingStatusEnum.DONE,
    nullable: false,
  })
  processing_status: ProcessingStatusEnum;

  @Column({ type: 'text', nullable: true })
  caption: string;

  @Column({ type: 'text', nullable: true })
  file_path: string;
}
