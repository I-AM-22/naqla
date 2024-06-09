export const ordersTagKeys = {
  root: "orders/",
  waiting() {
    return [this.root, this.root.concat("waiting")];
  },
  details() {
    return [this.root, this.root.concat("details")];
  },
};
