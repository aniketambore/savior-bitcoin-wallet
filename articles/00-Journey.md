# Developing a Non-Custodial Bitcoin Wallet with Flutter and BDK: My Journey

As a developer, I am always looking for new challenges and opportunities to learn. Recently, I decided to implement some of the projects defined in Advanced Topics and Next Steps in Chapter 14 of Programming Bitcoin by Jimmy Song. Specifically, I wanted to build a Bitcoin Testnet wallet as a mobile app using Flutter and the BDK library.

Before diving into coding, I wanted to make sure I had a strong understanding of the relevant standards and concepts. I reviewed BIP39, BIP32, BIP43, BIP44, and BIP84, and went through the complete documentation of BDK. I learned about Descriptors, which is a compact and semi-standard way to easily encode, or 'describe', how scripts (and subsequently, addresses) of a wallet should be generated. I also learned about PSBT (BIP:0174), which is how BDK signs the transaction and then broadcasts it while sending Bitcoins.

Next, I had to decide on the right package to use for my project. I looked at 'bitcoin_flutter' but noticed some open issues on Github indicating that the package is no longer maintained. Instead, I decided to go with 'bdk_flutter', which utilizes the Rust BDK as its core library and uses Flutter Rust Bridge for binding.

To structure the project, I split the codebase into multiple local packages for the complete project, which helped enforce separation of concerns, promote cleaner APIs, and manage dependencies better. I used a mixed approach of feature-by-layer and feature-by-package, with each package having a src folder and barrel file.

For data management, I followed the Repository pattern as there were two data sources (BDK and local cache) while getting the balance. I cached the wallet balance to improve user experience, allowing the app to respond faster. I had a different fetching policy while syncing the wallet and getting the balance.

For state management, I followed the BLoC design pattern using the flutter_bloc package from the bloc library, and used Cubit for most of the classes, which is actually a simplified version of a Bloc.

To handle routing in the app, I followed Navigator 2 wrapper package Routemaster, which handled all integration between the feature packages inside main.

From the start, I also focused on developing a common widget catalog for the project. Reusing already-created widgets saved a lot of time and effort when creating and maintaining the project. So I had a component library package.

The app's architecture starts with the SplashScreen, which checks whether a wallet has already been created/loaded, and if not, launches the CreateWalletScreen. 

The CreateWalletScreen displays two widgets: Create a New Wallet and Recover an Existing Wallet. 

If a wallet already exists on the device, the HomeScreen is launched. 

This screen contains the home wallet screen with the Drawer (containing the AboutScreen and RecoveryPhraseScreen). 

The HomeScreen is simply a container for navigating between ReceiveAddressScreen, SendScreen, and TxHistoryScreen.

I broke down the journey of building the wallet into 6 distinct steps:

1. Creating a BDKApi package and WalletRepository package
2. Implementing Receive and Sync functionalities
3. Implementing Send functionality
4. Displaying Transaction History
5. Displaying Recovery Phrase
6. Implementing Recover Wallet functionality using the mnemonic.

The screens are super intuitive and easy to use, which you can find in the feature folder.

Overall, building a Bitcoin Testnet wallet using Flutter and BDK was a challenging but rewarding experience. I learned a lot about Bitcoin standards and concepts, package selection, project structuring, data management, state management, routing, and widget catalogs. The end product is a cross-platform mobile app that can be used to test Bitcoin transactions on the Testnet network. The app provides a simple and intuitive interface for users to create and manage their Bitcoin wallets, view their transaction history, send and receive Bitcoin, and recover their wallets using a mnemonic seed phrase.

The use of BIP39, BIP32, BIP43, BIP44 and BIP84 standards ensures that the wallet is compatible with other wallets that follow the same standards. This means that users can easily recover their wallet using the mnemonic seed phrase in case they lose access to their device.

The architecture of the app is well-organized and follows the principles of separation of concerns, promoting cleaner APIs, and better dependency management. The app uses a feature-by-package and feature-by-layer approach, with local packages that promote modularity, scalability, and maintainability. The use of the Repository pattern allows for easy integration of multiple data sources, while the BLoC design pattern and Cubit simplify state management.


The app also uses a common widget catalog to promote code reusability, saving time and effort during development and maintenance. The use of Routemaster for navigation and integration between feature packages simplifies routing in the app, allowing for efficient navigation between screens.


Overall, the app provides a powerful and developer-friendly platform for building Bitcoin Testnet wallets. With its modular architecture, well-organized codebase, and intuitive interface, developers can easily build, test, and deploy Bitcoin wallets for both Android and iOS platforms. The use of industry-standard protocols and libraries ensures compatibility with other wallets and promotes security and reliability.

In conclusion, building a Bitcoin wallet is no easy task, but with the right tools and frameworks, developers can build robust and secure wallets that provide a seamless user experience. The use of Flutter, BDK, and other standards and protocols provides a powerful and reliable platform for building Bitcoin wallets. With the rise of Bitcoin, the need for secure and reliable wallets will only increase, and the development of apps like this is critical to the success of the Bitcoin ecosystem.