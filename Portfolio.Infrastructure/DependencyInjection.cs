using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Portfolio.Infrastructure.Persistence;

namespace Portfolio.Infrastructure
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration config)
        {
            var connString = config.GetConnectionString("Postgres")
                ?? throw new InvalidOperationException("ConnectionStrings:Postgres is not configured.");

            services.AddDbContext<Portfolio.Infrastructure.Persistence.AppDbContext>(options => options.UseNpgsql(connString));

            services.AddHealthChecks()
                .AddNpgSql(connString, name: "postgres");

            return services;
        }
    }
}
