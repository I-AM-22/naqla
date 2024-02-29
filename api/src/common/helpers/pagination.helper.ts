import { PaginatedResponse } from '../types';

export const pagination = (
  pageNumber: number,
  limit: number,
  totalDataCount: number,
  data: any[],
): PaginatedResponse<any> => {
  const totalPages = Math.ceil(totalDataCount / limit);
  return {
    pageNumber: pageNumber || 1,
    totalPages: totalPages || 1,
    totalDataCount,
    data,
  };
};
