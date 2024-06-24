import { Socket } from 'socket.io';

export type ISocketWithUser = Socket & {
  userId: string;
};
