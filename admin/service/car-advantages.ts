export const carAdvantagesTagKeys = {
  root: "car-advantages/",
  all() {
    return [this.root, this.root.concat("all")];
  },
  details(id: string) {
    return [this.root, this.root.concat(id)];
  },
};
