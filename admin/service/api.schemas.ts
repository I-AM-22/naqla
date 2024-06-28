/**
 * Generated by orval v6.25.0 🍺
 * Do not edit manually.
 * naqleh
 * naqleh API
 * OpenAPI spec version: 1.0
 */
export type SubOrdersMessagesControllerFindParams = {
  page?: number;
  limit?: number;
};

export type SubOrdersMessagesControllerFindPathParameters = {
  subOrderId: string;
};
export type MessagesControllerDeletePathParameters = {
  id: string;
};
export type MessagesControllerUpdatePathParameters = {
  id: string;
};
export type MessagesControllerFindOnePathParameters = {
  id: string;
};
export type MessagesControllerFindParams = {
  page?: number;
  limit?: number;
};

export type PhotosControllerUploadMultipleBody = {
  photos: Blob[];
};

export type PhotosControllerUploadSingleBody = {
  photo: Blob;
};

export type StatisticsControllerFindLimitAdvantagesPathParameters = {
  limit: number;
};
export type StatisticsControllerProfitsPathParameters = {
  firstDate: string;
  secondDate: string;
};
export type StatisticsControllerFindForDatePathParameters = {
  firstDate: string;
  secondDate: string;
};
export type AuthDriverControllerConfirmParams = {
  /**
   * assign true to the field to confirm new number
   */
  phoneConfirm: boolean;
};

export type AdminsControllerDeletePathParameters = {
  id: string;
};
export type AdminsControllerUpdatePathParameters = {
  id: string;
};
export type AdminsControllerFindOnePathParameters = {
  id: string;
};
export type EmployeesControllerDeletePathParameters = {
  id: string;
};
export type EmployeesControllerUpdatePathParameters = {
  id: string;
};
export type EmployeesControllerFindOnePathParameters = {
  id: string;
};
export type OrderCarControllerFindMineForOrderPathParameters = {
  id: string;
};
export type CarControllerRemoveAdvantagesFromCarPathParameters = {
  id: string;
  advantageId: string;
};
export type CarControllerAddAdvantagesToCarPathParameters = {
  id: string;
};
export type CarControllerDeletePathParameters = {
  id: string;
};
export type CarControllerUpdatePathParameters = {
  id: string;
};
export type CarControllerFindOnePathParameters = {
  id: string;
};
export type DriversControllerDeletePathParameters = {
  id: string;
};
export type DriversControllerUpdatePathParameters = {
  id: string;
};
export type DriversControllerFindOnePathParameters = {
  id: string;
};
export type DriversControllerWithdrawPathParameters = {
  id: string;
};
export type DriversControllerStaticsDriverParams = {
  page?: number;
  limit?: number;
};

export type DriversControllerFindParams = {
  page?: number;
  active: boolean;
  limit?: number;
};

export type OrdersSubOrdersControllerFindForOrderPathParameters = {
  id: string;
};
export type SubOrdersControllerSetDriverPathParameters = {
  id: string;
};
export type SubOrdersControllerSetDeliveredAtPathParameters = {
  id: string;
};
export type SubOrdersControllerSetPickedUpAtPathParameters = {
  id: string;
};
export type SubOrdersControllerSetArrivedAtPathParameters = {
  id: string;
};
export type SubOrdersControllerUpdatePathParameters = {
  id: string;
};
export type SubOrdersControllerDeletePathParameters = {
  id: string;
};
export type SubOrdersControllerFindOnePathParameters = {
  id: string;
};
export type SubOrdersControllerFindChatsParams = {
  page?: number;
  limit?: number;
};

export type SettingsControllerUpdatePathParameters = {
  id: string;
};
export type SettingsControllerFindOnePathParameters = {
  id: string;
};
export type AdvantagesControllerDeletePathParameters = {
  id: string;
};
export type AdvantagesControllerUpdatePathParameters = {
  id: string;
};
export type AdvantagesControllerFindOnePathParameters = {
  id: string;
};
export type OrderControllerRemoveAdvantagesFromOrderPathParameters = {
  id: string;
  advantageId: string;
};
export type OrderControllerAddAdvantagesToOrderPathParameters = {
  id: string;
};
export type OrderControllerRefusalPathParameters = {
  id: string;
};
export type OrderControllerCancellationPathParameters = {
  id: string;
};
export type OrderControllerAcceptancePathParameters = {
  id: string;
};
export type OrderControllerDeletePathParameters = {
  id: string;
};
export type OrderControllerUpdatePathParameters = {
  id: string;
};
export type OrderControllerFindOnePathParameters = {
  id: string;
};
export type CitiesControllerDeletePathParameters = {
  id: string;
};
export type CitiesControllerUpdatePathParameters = {
  id: string;
};
export type CitiesControllerFindOnePathParameters = {
  id: string;
};
export type PermissionsControllerFindOnePathParameters = {
  id: string;
};
export type RolesControllerDeletePermissionsPathParameters = {
  id: string;
};
export type RolesControllerAddPermissionsPathParameters = {
  id: string;
};
export type RolesControllerUpdatePathParameters = {
  id: string;
};
export type RolesControllerFindOnePathParameters = {
  id: string;
};
export type UsersControllerDeletePathParameters = {
  id: string;
};
export type UsersControllerUpdatePathParameters = {
  id: string;
};
export type UsersControllerFindOnePathParameters = {
  id: string;
};
export type UsersControllerDepositPathParameters = {
  id: string;
};
export type UsersControllerWithdrawPathParameters = {
  id: string;
};
export type UsersControllerStaticsUserParams = {
  page?: number;
  limit?: number;
};

export type UsersControllerGetMyPhotosParams = {
  limit?: unknown;
  page?: unknown;
};

export type UsersControllerFindParams = {
  page?: number;
  active: boolean;
  limit?: number;
};

export type AuthUserControllerConfirmParams = {
  /**
   * assign true to the field to confirm new number
   */
  phoneConfirm: boolean;
};

export type SocketMessageDto = {
  content: string;
  createdAt: Date;
  id: string;
  isUser: boolean;
  subOrderId: string;
  updatedAt: Date;
};

export type JoinChatDto = {
  subOrderId: string;
};

export type SuccessDto = {
  status: string;
};

export type Object = { [key: string]: any };

export type UpdateMessageDto = {
  content: string;
};

export type CreateMessageDto = {
  content: string;
  isUser: boolean;
  subOrderId: string;
};

export type Message = {
  content: string;
  createdAt: Date;
  id: string;
  isUser: boolean;
  updatedAt: Date;
};

export type PaginatedMessageResponse = {
  data: Message[];
  pageNumber: number;
  totalDataCount: number;
  totalPages: number;
};

export type AdvantageSuper = {
  advantage: string;
  countCarUsed: number;
  countUserUsed: number;
};

export type StaticProfits = {
  day: string;
  profits: number;
};

export type OrderStatsDate = {
  AllOrders: number;
  completedOrders: number;
  day: string;
  refusedOrders: number;
};

export type Time = {
  hours: number;
  milliseconds: number;
  minutes: number;
  seconds: number;
};

export type ResponseTime = {
  today: Time;
  yesterday: Time;
};

export type Numerical = {
  car: number;
  driver: number;
  orderActive: number;
  orderCompleted: number;
  orderWaiting: number;
  subOrderActive: number;
  subOrderCompleted: number;
  user: number;
};

export type UpdateDriverPhoneDto = {
  phone: string;
};

export type AuthDriverResponse = {
  driver: Driver;
  token: string;
};

export type ConfirmDriverDto = {
  otp: string;
  phone: string;
};

export type LoginDriverDto = {
  phone: string;
};

export type SignUpDriverDto = {
  firstName: string;
  lastName: string;
  phone: string;
};

export type UpdateAdminDto = {
  name?: string;
  password: string;
  phone: string;
  photo?: string;
};

export type CreateAdminDto = {
  firstName: string;
  lastName: string;
  password: string;
  phone: string;
  photo?: string;
};

export type Admin = {
  createdAt: Date;
  firstName: string;
  id: string;
  lastName: string;
  phone: string;
  photo: BasePhoto;
  updatedAt: Date;
};

export type AuthAdminResponse = {
  admin: Admin;
  token: string;
};

export type LoginAdminDto = {
  password: string;
  phone: string;
};

export type UpdateEmployeeDto = {
  address: string;
  name?: string;
  password: string;
  phone: string;
  photo?: string;
};

export type CreateEmployeeDto = {
  address: string;
  firstName: string;
  lastName: string;
  password: string;
  phone: string;
  photo?: string;
};

export type Employee = {
  createdAt: Date;
  firstName: string;
  id: string;
  lastName: string;
  phone: string;
  photo: BasePhoto;
  updatedAt: Date;
};

export type AuthEmployeeResponse = {
  employee: Employee;
  token: string;
};

export type LoginEmployeeDto = {
  password: string;
  phone: string;
};

export type AddAdvansToCarDto = {
  advantages: string[];
};

export type UpdateCarDto = {
  brand: string;
  color: string;
  model: string;
  photo: string;
};

export type CreateCarDto = {
  advantages: string[];
  brand: string;
  color: string;
  model: string;
  photo: string;
};

export type UpdateDriverDto = {
  firstName: string;
  lastName: string;
  photo: string;
};

export type DriverWallet = {
  available: Function;
  createdAt: Date;
  id: string;
  pending: number;
  total: number;
  updatedAt: Date;
};

export type StaticsDriver = {
  countCar: number;
  countOrderDelivered: number;
  createdAt: Date;
  firstName: string;
  id: string;
  lastName: string;
  phone: string;
  photo: BasePhoto;
  updatedAt: Date;
  wallet: DriverWallet;
};

export type Driver = {
  createdAt: Date;
  firstName: string;
  id: string;
  lastName: string;
  phone: string;
  photo: BasePhoto;
  updatedAt: Date;
  wallet: DriverWallet;
};

export type PaginatedDriverResponse = {
  data: Driver[];
  pageNumber: number;
  totalDataCount: number;
  totalPages: number;
};

export type Photo = {
  blurHash: string;
  createdAt: string;
  id: string;
  length: number;
  mobileUrl: string;
  profileUrl: string;
  updatedAt: string;
  webUrl: string;
  weight: number;
  width: number;
};

export type SetDriverSubOrderDto = {
  carId: string;
  rating: number;
};

export type UpdateSubOrderDto = {
  rating: number;
};

export type Car = {
  advantages: Advantage[];
  brand: string;
  color: string;
  createdAt: Date;
  id: string;
  model: string;
  photo: BasePhoto;
  updatedAt: Date;
};

export type OrderSubOrder = {
  acceptedAt: string;
  arrivedAt: string;
  car: Car;
  cost: number;
  createdAt: string;
  deliveredAt: string;
  driverAssignedAt: string;
  id: string;
  order: Order;
  photo: Photo;
  pickedUpAt: string;
  rating: number;
  status: string;
  updatedAt: string;
  weight: number;
};

export type SubOrder = {
  acceptedAt: Date;
  arrivedAt: Date;
  car: Car;
  cost: number;
  createdAt: Date;
  deliveredAt: Date;
  driverAssignedAt: Date;
  id: string;
  order: Order;
  photos: string[];
  pickedUpAt: Date;
  rating: number;
  realCost: number;
  status: string;
  updatedAt: Date;
  weight: number;
};

export type PaginatedSubOrderResponse = {
  data: SubOrder[];
  pageNumber: number;
  totalDataCount: number;
  totalPages: number;
};

export type CreateSubOrderDto = {
  photos: string[];
  weight: number;
};

export type CreateSubOrdersDto = {
  orderId: string;
  subOrders: CreateSubOrderDto[];
};

export type UpdateSettingDto = {
  cost?: number;
};

export type Setting = {
  cost: number;
  createdAt: Date;
  id: string;
  name: string;
  updatedAt: Date;
};

export type UpdateAdvantageDto = {
  cost?: number;
  name?: string;
};

export type CreateAdvantageDto = {
  cost: number;
  name: string;
};

export type AddAdvansToOrderDto = {
  advantages: string[];
};

export type UpdateOrderDto = {
  cost: number;
  desiredDate: Date;
  locationEnd: LocationDto;
  locationStart: LocationDto;
  photo: string[];
};

export type OrderStatus = (typeof OrderStatus)[keyof typeof OrderStatus];

// eslint-disable-next-line @typescript-eslint/no-redeclare
export const OrderStatus = {
  waiting: "waiting",
  ready: "ready",
  accepted: "accepted",
  refused: "refused",
  onTheWay: "onTheWay",
  delivered: "delivered",
  canceled: "canceled",
} as const;

export type Payment = {
  additionalCost: number;
  cost: number;
  createdAt: Date;
  deliveredDate: Date;
  id: string;
  updatedAt: Date;
};

export type Advantage = {
  cost: number;
  createdAt: Date;
  id: string;
  name: string;
  updatedAt: Date;
};

export type OrderPhoto = {
  blurHash: string;
  createdAt: Date;
  id: string;
  length: number;
  mobileUrl: string;
  profileUrl: string;
  updatedAt: Date;
  webUrl: string;
  weight: number;
  width: number;
};

export type MiniUser = {
  createdAt: Date;
  firstName: string;
  id: string;
  lastName: string;
  phone: string;
  photo: BasePhoto;
  updatedAt: Date;
};

export type Location = {
  latitude: number;
  longitude: number;
  region: string;
  street: string;
};

export type Order = {
  advantages: Advantage[];
  createdAt: Date;
  desiredDate: Date;
  id: string;
  locationEnd: Location;
  locationStart: Location;
  payment: Payment;
  photos: OrderPhoto[];
  porters: number;
  status: OrderStatus;
  updatedAt: Date;
  user: MiniUser;
};

export type Item = {
  length: number;
  photo: string;
  weight: number;
  width: number;
};

export type LocationDto = {
  latitude: number;
  longitude: number;
  region: string;
  street: string;
};

export type CreateOrderDto = {
  advantages: string[];
  desiredDate: Date;
  items: Item[];
  locationEnd: LocationDto;
  locationStart: LocationDto;
  porters: number;
};

export type UpdateCityDto = {
  name?: string;
};

export type City = {
  createdAt: Date;
  id: string;
  name: string;
  updatedAt: Date;
};

export type PaginatedCityResponse = {
  data: City[];
  pageNumber: number;
  totalDataCount: number;
  totalPages: number;
};

export type CreateCityDto = {
  name: string;
};

export type UpdateRoleDto = {
  permissionsIds: string[];
};

export type Permission = {
  action: string;
  createdAt: Date;
  id: string;
  subject: string;
  updatedAt: Date;
};

export type Role = {
  createdAt: Date;
  id: string;
  name: string;
  permissions: Permission[];
  updatedAt: Date;
};

export type CreateRoleDto = {
  /** the rule name */
  name: string;
  /** the Ids of permissions */
  permissionsIds: string[];
};

export type OmitTypeClass = {
  createdAt: Date;
  id: string;
  name: string;
  updatedAt: Date;
};

export type UpdateWalletDto = {
  cost: number;
};

export type UpdateUserDto = {
  firstName: string;
  lastName: string;
  photo: string;
};

export type GlobalEntity = {
  createdAt: Date;
  id: string;
  updatedAt: Date;
};

export type PaginatedResponse = {
  data: GlobalEntity[];
  pageNumber: number;
  totalDataCount: number;
  totalPages: number;
};

export type PaginatedUserResponse = {
  data: User[];
  pageNumber: number;
  totalDataCount: number;
  totalPages: number;
};

export type UpdateUserPhoneDto = {
  phone: string;
};

export type BasePhoto = {
  blurHash: string;
  createdAt: Date;
  id: string;
  mobileUrl: string;
  profileUrl: string;
  updatedAt: Date;
  webUrl: string;
};

export type Function = { [key: string]: any };

export type UserWallet = {
  available: Function;
  createdAt: Date;
  id: string;
  pending: number;
  total: number;
  updatedAt: Date;
};

export type StaticsUser = {
  active: boolean;
  countOrderDelivered: number;
  createdAt: Date;
  firstName: string;
  id: string;
  lastName: string;
  phone: string;
  photo: BasePhoto;
  updatedAt: Date;
  wallet: UserWallet;
};

export type User = {
  createdAt: Date;
  firstName: string;
  id: string;
  lastName: string;
  phone: string;
  photo: BasePhoto;
  updatedAt: Date;
  wallet: UserWallet;
};

export type AuthUserResponse = {
  token: string;
  user: User;
};

export type ConfirmUserDto = {
  otp: string;
  phone: string;
};

export type LoginUserDto = {
  phone: string;
};

export type SendConfirm = {
  message: string;
};

export type SignUpUserDto = {
  firstName: string;
  lastName: string;
  phone: string;
};

export type AppErrorType = (typeof AppErrorType)[keyof typeof AppErrorType];

// eslint-disable-next-line @typescript-eslint/no-redeclare
export const AppErrorType = {
  socket: "socket",
  from: "from",
  default: "default",
} as const;

export type AppError = {
  message?: string;
  type: AppErrorType;
};

export type CustomValidationErrorType =
  (typeof CustomValidationErrorType)[keyof typeof CustomValidationErrorType];

// eslint-disable-next-line @typescript-eslint/no-redeclare
export const CustomValidationErrorType = {
  socket: "socket",
  from: "from",
  default: "default",
} as const;

export type CustomValidationError = {
  errors?: string[];
  message?: string;
  type: CustomValidationErrorType;
};
