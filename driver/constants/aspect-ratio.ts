const RATIOS = {
  CAR: [4, 3],
};
export const ASPECT_RATIOS = RATIOS as { [K in keyof typeof RATIOS]: [number, number] };
