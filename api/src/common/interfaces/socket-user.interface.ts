import { Socket } from 'socket.io';
import { IPerson } from './person.interface';

export type ISocketWithUser = Socket & {
  user: IPerson;
};
