using Microsoft.EntityFrameworkCore;
using System.IO;
using LibrarySystemCore.Models;
using LibrarySystemCore.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// Add session support
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

// Add DbContext
builder.Services.AddDbContext<LibrarySystemContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("LibrarySystemConnection")));

// Configure web root explicitly to the project's wwwroot to avoid bin-relative fallback
builder.Environment.WebRootPath = Path.Combine(builder.Environment.ContentRootPath, "wwwroot");

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // Disabled HSTS and HTTPS redirection to avoid local http warning and port detection issues
    // app.UseHsts();
}

// Disable HTTPS redirection to allow running cleanly on http://localhost:5000 in dev
// app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();
app.UseSession();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Account}/{action=Login}/{id?}");

// Auto-create database in Development to avoid manual setup
if (app.Environment.IsDevelopment())
{
    using (var scope = app.Services.CreateScope())
    {
        var db = scope.ServiceProvider.GetRequiredService<LibrarySystemContext>();
        db.Database.EnsureCreated();

        // Seed minimal data
        if (!db.Admins.Any())
        {
            db.Admins.Add(new Admin
            {
                Name = "Admin",
                Email = "admin@library.com",
                Password = "admin123"
            });
        }

        if (!db.Branches.Any())
        {
            db.Branches.AddRange(
                new Branch { Branchname = "Computer Science" },
                new Branch { Branchname = "Information Technology" }
            );
        }

        if (!db.Publications.Any())
        {
            db.Publications.AddRange(
                new Publication { PublicationName = "Pearson" },
                new Publication { PublicationName = "O'Reilly" }
            );
        }

        if (!db.Students.Any())
        {
            db.Students.Add(new Student
            {
                Studentname = "Student One",
                Branch = "Computer Science",
                Email = "student1@library.com",
                Password = "student123",
                Image = "/img/std.png"
            });
        }

        db.SaveChanges();
    }
}

app.Run();
