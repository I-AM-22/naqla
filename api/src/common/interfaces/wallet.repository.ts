export interface IWalletRepository<T> {
  create(): T;

  updatePending?(id: string, cost: number): Promise<T>;

  restPending?(id: string): Promise<T>;

  deposit(id: string, cost: number): Promise<T>;

  withdrawForDriver?(id: string, cost: number): Promise<T>;

  withdraw(id: string, cost: number): Promise<T>;
}
