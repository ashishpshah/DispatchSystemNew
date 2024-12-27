using Dispatch_System;
using Dispatch_System.Infra;
using DocumentFormat.OpenXml.Office2016.Drawing.ChartDrawing;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.Extensions.Hosting;
using System.Globalization;
using VendorQRGeneration.Infra.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();//.AddJsonOptions(options => { options.JsonSerializerOptions.PropertyNamingPolicy = null; });

builder.Services.AddHttpClient();

builder.Services.AddHttpContextAccessor();

builder.Services.Configure<RequestLocalizationOptions>(options =>
{
	var cultureInfo = new CultureInfo("en-IN");
	cultureInfo.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
	cultureInfo.DateTimeFormat.LongDatePattern = "dd/MM/yyyy HH:mm:sss";

	var supportedCultures = new List<CultureInfo> { cultureInfo };

	options.DefaultRequestCulture = new Microsoft.AspNetCore.Localization.RequestCulture("en-IN");

	options.DefaultRequestCulture.Culture.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
	options.DefaultRequestCulture.Culture.DateTimeFormat.LongDatePattern = "dd/MM/yyyy HH:mm:sss";

	options.SupportedCultures = supportedCultures;
	options.SupportedUICultures = supportedCultures;
});

ConfigurationManager configuration = builder.Configuration; // allows both to access and to set up the config
IWebHostEnvironment environment = builder.Environment;

var culture = CultureInfo.CreateSpecificCulture("en-IN");

var dateformat = new DateTimeFormatInfo { ShortDatePattern = "dd/MM/yyyy", LongDatePattern = "dd/MM/yyyy HH:mm:sss" };

culture.DateTimeFormat = dateformat;

var supportedCultures = new[] { culture };

builder.Services.Configure<RequestLocalizationOptions>(options =>
{
	options.DefaultRequestCulture = new Microsoft.AspNetCore.Localization.RequestCulture(culture);
	options.SupportedCultures = supportedCultures;
	options.SupportedUICultures = supportedCultures;
});

builder.Services.AddSession(options => { options.IdleTimeout = TimeSpan.FromMinutes(120); });

builder.Services.AddCors();
builder.Services.AddSignalR();

builder.Services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
//builder.Services.AddScoped<IRepositoryWrapper, RepositoryWrapper>();

builder.Services.AddSingleton<SharedDataService>();
builder.Services.AddSingleton<SocketBackgroundTask>();
builder.Services.AddSingleton<ConveyorBackgroundTask>();
////builder.Services.AddScoped<IBackgroundTaskService, BackgroundTaskService>();
//builder.Services.AddHostedService<SocketBackgroundTask>();
//builder.Services.AddSingleton<IWorker, Worker>();

var app = builder.Build();

AppHttpContextAccessor.Configure(((IApplicationBuilder)app).ApplicationServices.GetRequiredService<IHttpContextAccessor>(), ((IApplicationBuilder)app).ApplicationServices.GetRequiredService<IHostEnvironment>(), environment, ((IApplicationBuilder)app).ApplicationServices.GetRequiredService<IDataProtectionProvider>(), ((IApplicationBuilder)app).ApplicationServices.GetRequiredService<IConfiguration>(), ((IApplicationBuilder)app).ApplicationServices.GetRequiredService<IHttpClientFactory>());

//// Get the service provider
//using (var serviceScope = app.Services.CreateScope())
//{
//	var services = serviceScope.ServiceProvider;

//	try
//	{
//		// Resolve the IHostedService implementation (SocketWorker)
//		var socketWorker = services.GetRequiredService<SocketBackgroundTask>();

//		if (socketWorker.IsRunning())
//			await socketWorker.StopAsync(default);
//	}
//	catch (Exception ex)
//	{
//		// Handle any errors
//		// Log the error, display a message, etc.
//		Console.WriteLine("Error starting SocketWorker: " + ex.Message);
//	}
//}

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
	app.UseExceptionHandler("/Home/Error");
	// The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
	app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.UseSession();

// Register your custom ActionMiddleware
app.UseMiddleware<Dispatch_System.Infra.RedirectMiddleware>();

app.UseCors(builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader());

app.MapHub<ConveyorHub>("/conveyorhub");

app.MapControllerRoute(
    name: "qr",
    pattern: "{qr_prefix}/{gtin?}/{prod_cd?}/{qr_postfix?}",
    defaults: new { controller = "Home", action = "Get_QR_Code_Details" },
    constraints: new { qr_prefix = new StartsNumericConstraint() });

app.MapControllerRoute(
	  name: "areas",
	  pattern: "{area:exists}/{controller=Home}/{action=Index}/{id?}");

app.MapControllerRoute(
	name: "default",
	pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
