import { UUID } from 'crypto';

export interface jwtPayload {
  sub: UUID;
  entity: string;
  iat: number;
  exp: number;
}
