class PaginationUtil {
    // Get Transactions List with Pagination
    getPaginatedData = (data, page, limit) => {
        const { count: totalItems, rows: transactions } = data;
        const currentPage = page ? +page : 1; // default page 1
        const totalPages = Math.ceil(totalItems / limit);
    
        return { totalItems, transactions, totalPages, currentPage };
    };

    // Paging params with default values if client did not specify params
    getPagination = (page, size) => {
        const limit = size ? +size : 5;
        // Sequelize starts counting from 0 - fix to correct the currentPage result
        const offset = page ? (page - 1) * limit : 0;
    
        return { limit, offset };
    };
}

module.exports = PaginationUtil;