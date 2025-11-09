import { Entity, Column, PrimaryColumn } from 'typeorm';
import { AbstractEntity } from './abstract.entity';

@Entity('media_tags')
export class MediaTags extends AbstractEntity {
  @PrimaryColumn({ type: 'int' })
  media_id: number;

  @PrimaryColumn({ type: 'int' })
  tag_id: number;
}
