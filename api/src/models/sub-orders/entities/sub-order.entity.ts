import { Entity } from 'typeorm';
import { GlobalEntity } from '../../../common/base';

@Entity('sub-orders')
export class SubOrder extends GlobalEntity {}
