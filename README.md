# Library System - ASP.NET Core 9 MVC

This is a converted version of the Library System from .NET Framework (ASP.NET Web Forms) to ASP.NET Core 9 MVC.

## Features

- **Admin Portal**
  - Add/Manage Publications
  - Add/Manage Branches
  - Add/Manage Books
  - Add/Manage Students
  - Issue Books to Students
  - Return Books
  - View Reports (Books, Students, Issues, Penalties)

- **Student Portal**
  - View Issued Books
  - Check Book Status

## Prerequisites

- .NET 9.0 SDK
- SQL Server (LocalDB, Express, or Full)
- Visual Studio 2022 or VS Code

## Database Setup

### Option 1: Using SQL Script (Recommended)

1. Open SQL Server Management Studio (SSMS)
2. Connect to your SQL Server instance (LAPTOP-83GOR2JH or change in appsettings.json)
3. Open and execute `DatabaseScript.sql`
4. This will create the database, tables, and insert sample data

### Option 2: Using Entity Framework Migrations

```bash
# Navigate to project directory
cd LibrarySystemCore

# Add migration
dotnet ef migrations add InitialCreate

# Update database
dotnet ef database update
```

**Note:** After using migrations, you'll need to manually insert an admin user:

```sql
USE LibrarySystem;
INSERT INTO ADMIN (name, email, password) VALUES ('Admin', 'admin@library.com', 'admin123');
```

## Configuration

Update the connection string in `appsettings.json` if needed:

```json
"ConnectionStrings": {
  "LibrarySystemConnection": "Server=YOUR_SERVER;Database=LibrarySystem;Integrated Security=True;TrustServerCertificate=True"
}
```

Replace `YOUR_SERVER` with your SQL Server instance name.

## Running the Application

### Using Visual Studio
1. Open `LibrarySystemCore.csproj`
2. Press F5 to run

### Using Command Line
```bash
cd LibrarySystemCore
dotnet restore
dotnet build
dotnet run
```

The application will start at `https://localhost:5001` or `http://localhost:5000`

## Default Login Credentials

### Admin/Librarian
- **Username:** admin@library.com
- **Password:** admin123

### Student
- Create a student account through the admin portal first

## Project Structure

```
LibrarySystemCore/
├── Controllers/          # MVC Controllers
├── Models/              # Entity Models
├── Views/               # Razor Views
├── Data/                # DbContext
├── wwwroot/             # Static files (CSS, JS, Images)
│   ├── css/
│   ├── js/
│   ├── img/             # Store images here
│   └── Book/            # Store book images here
├── appsettings.json     # Configuration
└── Program.cs           # Application entry point
```

## Static Assets

The old WebForms static assets have been copied:
- `wwwroot/img/` contains shared images
- `wwwroot/Book/` contains book cover images

If anything is missing, copy from the legacy path `LibrarySystem/` into `wwwroot/`.

## Key Changes from .NET Framework

1. **ASPX to Razor Views**: All `.aspx` pages converted to `.cshtml` Razor views
2. **Code-Behind to Controllers**: Logic moved from `.aspx.cs` to MVC Controllers
3. **TableAdapters to EF Core**: Data access changed from ADO.NET TableAdapters to Entity Framework Core
4. **Session Management**: Updated to use ASP.NET Core session
5. **File Uploads**: Changed to use `IFormFile`
6. **Master Pages to Layout**: `MasterPage.master` converted to `_Layout.cshtml`

## API Endpoints

The application includes AJAX endpoints for dynamic functionality:
- `/Rent/GetBooksByPublication` - Get books by publication
- `/Rent/GetBookDetails` - Get book details
- `/Rent/GetStudentsByBranch` - Get students by branch
- `/Rent/GetIssuedBooks` - Get issued books for a student
- `/Rent/IssueBook` - Issue a book
- `/Rent/ReturnBook` - Return a book

## Troubleshooting

### Database Connection Issues
- Verify SQL Server is running
- Check connection string in `appsettings.json`
- Ensure Windows Authentication is enabled or use SQL Authentication

### Missing Images
- Ensure `wwwroot/img/` and `wwwroot/Book/` folders exist
- Copy images from old project to new `wwwroot` folder

### Migration Issues
```bash
# Remove migrations
dotnet ef migrations remove

# Create new migration
dotnet ef migrations add InitialCreate

# Update database
dotnet ef database update
```

## License

Educational Project
