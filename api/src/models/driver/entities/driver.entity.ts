import { Entity } from 'typeorm';
import { BasePerson } from '../../../common/entities';

@Entity('drivers')
export class Driver extends BasePerson {}
