import { Entity, Column } from 'typeorm';
import { AbstractEntity } from './abstract.entity';

@Entity('tags')
export class Tags extends AbstractEntity {
  @Column({ type: 'varchar', length: 64, unique: true, nullable: false })
  name: string;
}
