import { Entity, Column, Index, PrimaryColumn } from 'typeorm';
import { AbstractEntity } from './abstract.entity';

@Entity('album_media')
export class AlbumMedia extends AbstractEntity{
  @PrimaryColumn({ type: 'int' })
  album_id: number;

  @PrimaryColumn({ type: 'int' })
  media_id: number;

  @Column({ type: 'int', nullable: true })
  added_by: number;
}
