/// Defines a service: a singleton object to manage a resource.
abstract class Service {
	/// Initializes any resources needed by the service.
	/// 
	/// This is guaranteed to be called before any other methods.
	Future<void> init();

	/// Disposes any resources used by the service.
	Future<void> dispose();
}
