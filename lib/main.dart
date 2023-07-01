import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mypfe/constants/user_constants.dart';
import 'package:mypfe/services/auth/auth_services.dart';
import 'package:mypfe/services/cloud/storage/user_storage.dart';
import 'package:mypfe/views/adminView/admin/create_or_update_admin.dart';
import 'package:mypfe/views/adminView/companies/create_or_update_company.dart';
import 'package:mypfe/views/adminView/main_admin_ui.dart';
import 'package:mypfe/views/adminView/stations/create_or_update_station.dart';
import 'package:mypfe/views/authView/forget_pwd.dart';
import 'package:mypfe/views/authView/login.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:mypfe/views/authView/register.dart';
import 'package:mypfe/views/authView/verify_email.dart';
import 'package:mypfe/views/clientView/bookingViews/choose_passenger.dart';
import 'package:mypfe/views/clientView/bookingViews/home_page.dart';
import 'package:mypfe/views/clientView/bookingViews/paiement_view.dart';
import 'package:mypfe/views/clientView/main_client.dart';
import 'package:mypfe/views/clientView/bookingViews/tickets_result.dart';
import 'package:mypfe/views/companyView/main_company.dart';
import 'package:mypfe/views/companyView/tickets/main_tickets_view.dart';
import 'package:mypfe/views/companyView/trains/classeView/add_class.dart';
import 'package:mypfe/views/companyView/trains/classeView/create_update_classe.dart';
import 'package:mypfe/views/companyView/trains/create_or_update_train.dart';
import 'package:mypfe/widgets/booking/add_passenger.dart';
import 'package:mypfe/widgets/tickets/add_ticket.dart';

import 'constants/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Lock Device orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sany',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 74, 44, 156)),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle:  TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 113, 68, 239),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        //Auth Pages
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerificationEmail(),
        resetPassordRoute: (context) => const ForgetPasswordView(),
        //Main Pages
        mainAdminRoute: (context) => const MainAdminPage(),
        mainCompanyRoute: (context) => const MainCompanyPage(),
        mainClientRoute: (context) => const MainClientPage(),
        clientHomePageRoute:(context) => const ClientHomePage(),
        mainTicketRoute:(context) => const MainTicketView(),
        //Forms Pages
        createOrUpdateCompanyRoute: (context) => const CreateOrUpdateCompany(),
        createOrUpdateStationRoute: (context) => const CreateOrUpdateStation(),
        createOrUpdateAdminRoute: (context) => const CreateOrUpdateAdmin(),
        createOrUpdateTrainRoute:(context) => const CreateOrUpdateTrain(),
        createOrUpdateClasseRoute:(context) => const CreateOrUpdateClasse(),
        addClasseRoute: (context) => const AddClasse(),
        addPassengerRoute:(context) => const AddPassengers(),
        createOrUpdateTicketRoute:(context) => const AddTicket(),
        
        //Navigation Pages
        ticketsResultsRoute:(context) => const TicketsResults(),
        
        choosePassengerRoute:(context) => const ChoosePassenger(),
        paiementViewRoute:(context) => const PaiementView(),
      },
      home: const FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final firebaseCloudService = FirebaseCloudUserStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialise(),
      builder: (ctx, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('Error');
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;

            //? Verifier si le user est connecté
            if (user != null) {
              final role = firebaseCloudService.getRole(email: user.email);
              if (user.isEmailVerified) {
                // ignore: unrelated_type_equality_checks
                if (role == owner) {
                  return const MainAdminPage();
                  // ignore: unrelated_type_equality_checks
                } else if (role == partenaire) {
                  return const MainCompanyPage();
                  // ignore: unrelated_type_equality_checks
                } else if (role == client) {
                  return const MainClientPage();
                } else {
                  return const LoginView();
                }
              } else {
                return const VerificationEmail();
              }
            } else {
              return const LoginView();
            }
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
