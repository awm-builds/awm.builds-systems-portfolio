using Microsoft.EntityFrameworkCore;

namespace Portfolio.Infrastructure.Persistence
{
    public sealed class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }

        // Add DbSet<T> properties here
    }
}