import { Injectable } from '@nestjs/common';
import axios from 'axios';
import { Location } from '@models/orders/interfaces/location.interface';

@Injectable()
export class GpsDrivingService {
  constructor() {}
  async costDistance(point1: Location, point2: Location): Promise<number> {
    const apiUrl = `https://router.project-osrm.org/route/v1/driving/${point1.longitude},${point1.latitude};${point2.longitude},${point2.latitude}?overview=false`; //جلب المسافة والمدة بين نقطتين
    // const apiUrl=`https://router.project-osrm.org/route/v1/driving/${point1.longitude},${point1.latitude};${point2.longitude},${point2.latitude}?steps=true`;//تفاصيل النقاط على الطريق
    const response = await axios.get(apiUrl);
    return response.data.routes[0].distance;
  }
}
