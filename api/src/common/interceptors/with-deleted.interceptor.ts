import { CallHandler, ExecutionContext, Injectable, NestInterceptor } from '@nestjs/common';
import { Observable, tap } from 'rxjs';
import { User } from '@models/users/entities/user.entity';

@Injectable()
export class WithDeletedInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler<any>): Observable<any> | Promise<Observable<any>> {
    const req = context.switchToHttp().getRequest();
    const { user }: { user: User } = req;
    if (user.role.name.includes('admin')) {
      req.query.withDeleted = true;
    } else req.query.withDeleted = false;
    return next.handle().pipe(tap());
  }
}
