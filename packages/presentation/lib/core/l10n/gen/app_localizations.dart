
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'King Karel'**
  String get appName;

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'King Karel'**
  String get appTitle;

  /// The description of the loading text
  ///
  /// In en, this message translates to:
  /// **'loading...'**
  String get loadingText;

  /// The description on main screen of the application
  ///
  /// In en, this message translates to:
  /// **'King Karel is an educational game with programming puzzles. The game aims at children and other beginners, who will playfully learn the concepts of programming and algorithms.'**
  String get appHomeDescription;

  /// The button to go to settings in profile screen
  ///
  /// In en, this message translates to:
  /// **'go to settings'**
  String get profileSettingsButton;

  /// The title of the unknown screen
  ///
  /// In en, this message translates to:
  /// **'404'**
  String get unknownScreenTitle;

  /// The description of the unknown screen
  ///
  /// In en, this message translates to:
  /// **'The Page you are looking for doesn\'t exist or an other error occurred.'**
  String get unknownScreenBody;

  /// The description of the stories title
  ///
  /// In en, this message translates to:
  /// **'stories'**
  String get storiesTitle;

  /// The description of the stories screen
  ///
  /// In en, this message translates to:
  /// **'Welcome adventurer. Help the king complete the tasks and become one of the legends.'**
  String get storiesDescription;

  /// The description of the count of missions the story contains.
  ///
  /// In en, this message translates to:
  /// **'contains {count} missions'**
  String storiesMissionCountDescription(int count);

  /// The description of stories button.
  ///
  /// In en, this message translates to:
  /// **'stories'**
  String get storiesButton;

  /// The label for places where no data are available.
  ///
  /// In en, this message translates to:
  /// **'There are no data available.'**
  String get noDataLabel;

  /// The description for fail dialog on the mission screen.
  ///
  /// In en, this message translates to:
  /// **'You have failed the mission. Try again!'**
  String get missionFailDescription;

  /// The description for success dialog on the mission screen.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You have successfully completed the mission!'**
  String get missionSuccessDescription;

  /// The button for dialog try again button.
  ///
  /// In en, this message translates to:
  /// **'try again'**
  String get missionDialogTryAgainButton;

  /// The button for dialog back to the story button.
  ///
  /// In en, this message translates to:
  /// **'back to the story'**
  String get missionDialogBackToStoryButton;

  /// The description of the button to save a game.
  ///
  /// In en, this message translates to:
  /// **'save game'**
  String get gameSaveButton;

  /// The description of the button to reset a game grid.
  ///
  /// In en, this message translates to:
  /// **'reset grid'**
  String get gameResetButton;

  /// The description of the button to stop a game in progress.
  ///
  /// In en, this message translates to:
  /// **'stop game'**
  String get gameStopButton;

  /// The description of the button to run a game.
  ///
  /// In en, this message translates to:
  /// **'run game'**
  String get gameRunButton;

  /// The description of the unknown condition.
  ///
  /// In en, this message translates to:
  /// **'?'**
  String get gameConditionUnknown;

  /// The description of the condition 'can move up'.
  ///
  /// In en, this message translates to:
  /// **'can move up'**
  String get gameConditionCanMoveUp;

  /// The description of the condition 'can move right'.
  ///
  /// In en, this message translates to:
  /// **'can move right'**
  String get gameConditionCanMoveRight;

  /// The description of the condition 'can move down'.
  ///
  /// In en, this message translates to:
  /// **'can move down'**
  String get gameConditionCanMoveDown;

  /// The description of the condition 'can move left'.
  ///
  /// In en, this message translates to:
  /// **'can move left'**
  String get gameConditionCanMoveLeft;

  /// The description of the condition 'can place mark'.
  ///
  /// In en, this message translates to:
  /// **'can place mark'**
  String get gameConditionCanPlaceMark;

  /// The description of the condition 'can grab mark'.
  ///
  /// In en, this message translates to:
  /// **'can grab mark'**
  String get gameConditionCanGrabMark;

  /// The description of the unknown direction.
  ///
  /// In en, this message translates to:
  /// **'?'**
  String get gameDirectionUnknown;

  /// The description of the direction 'up'.
  ///
  /// In en, this message translates to:
  /// **'up'**
  String get gameDirectionUp;

  /// The description of the direction 'right'.
  ///
  /// In en, this message translates to:
  /// **'right'**
  String get gameDirectionRight;

  /// The description of the direction 'down'.
  ///
  /// In en, this message translates to:
  /// **'down'**
  String get gameDirectionDown;

  /// The description of the direction 'left'.
  ///
  /// In en, this message translates to:
  /// **'left'**
  String get gameDirectionLeft;

  /// The title of the game mission description section.
  ///
  /// In en, this message translates to:
  /// **'mission description'**
  String get gameDescriptionTitle;

  /// The description of the show description button.
  ///
  /// In en, this message translates to:
  /// **'show description'**
  String get gameShowDescriptionButton;

  /// The description of the hide description button.
  ///
  /// In en, this message translates to:
  /// **'hide description'**
  String get gameHideDescriptionButton;

  /// The description of the game in progress.
  ///
  /// In en, this message translates to:
  /// **'The game is running.'**
  String get gameRunningDescription;

  /// The description of the unknown process game error.
  ///
  /// In en, this message translates to:
  /// **'?'**
  String get processGameErrorUnknown;

  /// The description of the process game error with invalid commands.
  ///
  /// In en, this message translates to:
  /// **'Some of the commands are in invalid state. Make sure all command options are selected.'**
  String get processGameErrorHasInvalidCommands;

  /// The description of the process game error with invalid move command.
  ///
  /// In en, this message translates to:
  /// **'You tried to move out of the grid or to non walkable cell.'**
  String get processGameErrorInvalidMove;

  /// The description of the process game error with invalid put mark command.
  ///
  /// In en, this message translates to:
  /// **'You tried to put mark into a full cell.'**
  String get processGameErrorInvalidPutMark;

  /// The description of the process game error with invalid grab mark command.
  ///
  /// In en, this message translates to:
  /// **'You tried to grab mark from an empty cell.'**
  String get processGameErrorInvalidGrabMark;

  /// The description of the process game error with exceeded speed limit.
  ///
  /// In en, this message translates to:
  /// **'You exceeded the speed limit. Check your repeating loops.'**
  String get processGameErrorExceededSpeedLimit;

  /// The title of the palette section of the mission's tree view.
  ///
  /// In en, this message translates to:
  /// **'palette'**
  String get paletteTitle;

  /// The title of the stats screen.
  ///
  /// In en, this message translates to:
  /// **'stats'**
  String get statsTitle;

  /// The title of the column for username on stats screen.
  ///
  /// In en, this message translates to:
  /// **'username'**
  String get statsUsernameColumn;

  /// The title of the column for completed on stats screen.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get statsCompletedColumn;

  /// The title of the column for size on stats screen.
  ///
  /// In en, this message translates to:
  /// **'size'**
  String get statsSizeColumn;

  /// The title of the column for speed on stats screen.
  ///
  /// In en, this message translates to:
  /// **'speed'**
  String get statsSpeedColumn;

  /// The text of form field validator while being entry
  ///
  /// In en, this message translates to:
  /// **'Please enter some text'**
  String get formFieldValidatorEmptyText;

  /// The label of the username text input
  ///
  /// In en, this message translates to:
  /// **'username'**
  String get formUsernameLabel;

  /// The label of the real name text input
  ///
  /// In en, this message translates to:
  /// **'real name'**
  String get formRealNameLabel;

  /// The label of the password text input
  ///
  /// In en, this message translates to:
  /// **'password'**
  String get formPasswordLabel;

  /// The label of the description text input
  ///
  /// In en, this message translates to:
  /// **'description'**
  String get formDescriptionLabel;

  /// The label of the email text input
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get formEmailLabel;

  /// The description of sign in screen
  ///
  /// In en, this message translates to:
  /// **'sign in'**
  String get signInTitle;

  /// The description of sign in button
  ///
  /// In en, this message translates to:
  /// **'sign in'**
  String get signInButton;

  /// The description of sign out button
  ///
  /// In en, this message translates to:
  /// **'sign out'**
  String get signOutButton;

  /// The description of sign up screen
  ///
  /// In en, this message translates to:
  /// **'sign up'**
  String get signUpTitle;

  /// The description of sign up button
  ///
  /// In en, this message translates to:
  /// **'sign up'**
  String get signUpButton;

  /// The description of profile button
  ///
  /// In en, this message translates to:
  /// **'profile'**
  String get profileButton;

  /// The description of settings screen title
  ///
  /// In en, this message translates to:
  /// **'settings'**
  String get settingsTitle;

  /// The description of settings button
  ///
  /// In en, this message translates to:
  /// **'settings'**
  String get settingsButton;

  /// The title of About Us screen
  ///
  /// In en, this message translates to:
  /// **'about us'**
  String get aboutUsTitle;

  /// The description of the about us button
  ///
  /// In en, this message translates to:
  /// **'about'**
  String get aboutUsButton;

  /// The description of the approach button
  ///
  /// In en, this message translates to:
  /// **'approach'**
  String get aboutUsApproachButton;

  /// The about us approach content
  ///
  /// In en, this message translates to:
  /// **'# Nunc qui iniquis mansit\n\n## Falsa suam hastam triumphos\n\nLorem markdownum contentus claudor o *caesa dictaque belloque* et laesasque\nante, non ipsa crinis, reficisque certamen terga? Tamen bifores captabat acuta,\nnos barba Est spinis locus fassurae: mera sic unum retia adductaque niveae et!\nData fulgure coleretur et monstro venit defecerat mecumque cum quam illa dis\nhaud! Iamque et pariter et operatus temperat agitataque suis exsultantemque\nPhoebus. Est dixit, viae Troiae tamquam subducere stabantque captae!\n\n    viral_url(biosRecord, 3 - trim_zettabyte_express);\n    if (core_gif_footer(linkedin, rasterPlainExif) >= scroll_banner_megapixel(\n            linkedin_computer, logic_dns_biometrics, cdDomain)) {\n        queue += wormStreaming;\n        sla_gui = -1 * archive;\n    } else {\n        process(rw_leopard_kvm(-4));\n        base *= -4;\n    }\n    kindle_macro_san = isp;\n\nMonte altera [mentas infelix](http://www.viscera-illa.io/) et **nexis adnuit**,\nTagus Rhamnusia Phoebe volui, domino fuit Euippe. Remos a copia glandes quanto,\ncum satis coniuge.\n\nIlle tempore *felix loquendi*, et **cuspidis fertque** dilectaque media\nadsimulat in mirantia tempore. Cupidine abit; robora fretum, **et pectora\nfulvaque**, orbe patris Quin iactanti invenies volui, domini num ipsis. Corpus\nArgum vidit potuitque motus nituntur: deus redde esse. Vox maior [quae saevaeque\nsubolemque](http://aere.net/feceratexemplumque) palustres refers.\n\n## Frondibus certas aequoreos patris moenibus gaudere efflant\n\nSolidae serva operisque, raptum nec illic alta Aeolidae, cetera avium, vocari\nvenerit. Arma fuge? Pars Aeacus sequiturque artes pulcherrima genitor onus ego\ninferias *pugnat odoratis* et misce inponit. Apte huic Ixione dextera inmotus\naliis uterque singula capax: nescio Veneri differt laevam cum! Temptat suis, non\ninscius [quoque quoque](http://ut-videri.org/situs) sistraque postmodo dixit,\nlevis regnum terga suo per orbataque nudos adhuc.\n\nConcipit *facit retices tauri* opusque ignes arcum nitidum, nam foret. Vultum\nvocali, scopulum levavit nec similis frequens mittor? Ad ecce natam: deus [fuit\nmortale](http://minimamtempore.net/) reicere adstitit perspicit umbrae verruntur\nsilvas Veneris, adnuerant. Ferasque in non Remulusque altae sollicitis et\ninsanis opes pedum *valet* Medusa [recentes\net](http://obscenas.io/auferatalbaque), ferarum.\n\n1. Nam instruxere dirusque qui Pelasgi sensimus pulsat\n2. Sparten capillis\n3. Adspicit exul\n\nHabuere et nulla moenia madefecit trabemque\n[tepidis](http://vult-plena.org/sui-foret), tum in. Falsum errat in mihi\nletiferam, tandem relinquam. Opus est; frutices nomen deae hic pruinas; inquit.'**
  String get aboutUsApproachContent;

  /// The description of the apps button
  ///
  /// In en, this message translates to:
  /// **'apps'**
  String get aboutUsAppsButton;

  /// The about us apps content
  ///
  /// In en, this message translates to:
  /// **'# Parte velit iuva sum mei paelicis misit\n\n## A dubitaret duce ostendisse ossa iungere citius\n\nLorem markdownum relinquar patiar? Proturbat feret Argolicas illos mea specto\nsomni, orant mittuntque conditaque certeque victrix mente summam dispar\nstabantque. Arcuit [in ac custodes](http://qui.com/ambiguo) habet, arva malum\nhorrida, et summa una sentiat et. Genitor regnumque illa dextra habet fundamine\nreferre: cautum radii vita atlas et quoque generis. Stygiis quisquis, umbra\nEnipeu illud protinus at haec, quas umentes iram solvit missa, per terrae,\nvirgo.\n\n- Novis ossa rite conscia vidit\n- Perque vale imago sunt\n- Flumina praecordia dumque diros caluere facies\n\nNec praestem pressit in maris: repetam non *vacca se* posuere illo quae, geniti\nest omnes. Tua ora et patremque mole colla liquidis ululasse palmite pendentia\narboris, id pater publica; verba suos trabemque fossa? Veras referente. Densi\ntigride, turpi retinere possit locis quaerentibus crimen ab. Erigitur decorem\nnec sed sanguine *voti* et quam revulsum extremo ab\n[Circaea](http://tamen-intra.net/).\n\n## Neque pavet fuerat data quae quisquam manabant\n\nPeregrinaeque medullas quid omnes: utque absentem paelice arma fuge convicia iam\nmatris nunc quodcumque mediis, subeant Nisi frustra. Est ventre animae est ante,\nSamon qui ignara patent, **ipse**. Hic causam regionibus ante oscula prosilit\nmearum et perdere **volentem** lucis. Ultorque flumina pavetque inrita\n**parantes** iactantem certamina timide faciemque recepit ait: marmore: tinxit\nPaphius. In mediusve amor et refert creamur tandem tristis cum cuiquam incerta,\nunda nec crinibus Cadmus in **oraque** reclusa.\n\n    if (rasterDvdCaps * scareware) {\n        bsod = installer_title(smart_system, multiplatformSlaSo + 1);\n        fiber.rt(extranet_dashboard_oop + 4);\n    } else {\n        install_mouse_click += print;\n        services.ssl = 1 + 3 - odbc;\n        trackbackParty = window;\n    }\n    wirelessSyncAddress(byteMicrocomputerCard(7), windowsFormat(pc, virusFloppy,\n            1));\n    encoding_web_illegal += keyboardRaster;\n    map_network(ring(dos_core * megahertz), 88);\n    if (mca + bitmap_unix + ipad_wins != matrix_veronica_file(unicode_tebibyte,\n            2, dslamWebMemory)) {\n        meme_key.market = -1;\n        dviWrapThumbnail = gigabit;\n        number.public_ip = file_interactive_controller;\n    }\n\nViri sunt usque, alter furit frui [moverent](http://vitamqueinpositum.org/).\nQuam Daphne.\n\nPoteras ibi parentes: *constant monet* defendere agat os perluitur. Quantum\nCeres est cuspidis, hic, [Helicen deus](http://coloni-quantum.io/iamhunc.aspx)\noraque.'**
  String get aboutUsAppsContent;

  /// The description of the contact button
  ///
  /// In en, this message translates to:
  /// **'contact'**
  String get aboutUsContactButton;

  /// The about us contact content
  ///
  /// In en, this message translates to:
  /// **'# Est tardius rostro viscera\n\n## Telamon heres movet nisi cibo\n\nLorem markdownum spectem venerisque conatibus imagine deducite. Iras quo tumulis\nfidem quam nullamque aenis condiderant, frequentes. Quibus finem parente\ncarmina. Lernaeae Atlantide Liber pars dura ignibus flumina autem amplexus! Quid\ncur voti, ego nuper patent neque fera genetrixque videbor gradus vestigia\noccidit isse vetustas rursusque tingui.\n\n- Acumine placetque et vultus plausis laudemur functa\n- Agricolam muros cinis nudos serta prope radere\n- Et fulmen pervenit mihi in currus orator\n- Liquebat Arcades\n- Inter mixtusque me rectior gelidis\n- Sisyphon parte properata miles'**
  String get aboutUsContactContent;

  /// The description of the guidelines button
  ///
  /// In en, this message translates to:
  /// **'guidelines'**
  String get aboutUsGuidelinesButton;

  /// The about us guidelines content
  ///
  /// In en, this message translates to:
  /// **'# Quasi mihi votisque turba\n\n## Fluidos omnibus ortus mihi\n\nLorem markdownum tegit vocari, es tectos [figura aequorque\ntotidem](http://www.indis.net/) premunt ferarum. Non nubila ad cessit lacrimae\nvocem; digna ipse fagus.\n\n1. Revincta gentes infelix\n2. Imperat mox nam Telamone saxaque\n3. Eripiunt pendet ferunt ut bis illo pater\n4. Simillima vertit manuque incidit ratibusque dum hic'**
  String get aboutUsGuidelinesContent;

  /// The description of the help button
  ///
  /// In en, this message translates to:
  /// **'help'**
  String get aboutUsHelpButton;

  /// The about us help content
  ///
  /// In en, this message translates to:
  /// **'## Superas docebo rubefactaque furtique petunt visum insequitur\n\nOrtu formosus me moriens tacita defendere palam, auferat mea. Terga est solet\nfronde posita natus cum inde concidere quo hoc, ore cum, fluitque, numina, Iam?\nSed leto carica membris crimine, tuis quam conveniant *Phrygiae*, ipso, ora hic;\nmaris admota difficili. Gregesque undis *longam reice* visa mox aquis flammas\ndiscriminis putat exspectatum aquas serpentis manibusque differt sunt: dicere\n[miscenda at](http://remotamnervis.io/arsit-semesarumque.aspx).\n\n1. De finibus attolle\n2. Descendit modo erit nemus gressu orbem haesit\n3. Dominasque poma cremet illa quibus finxit\n4. Per vigil movebo Maiaque i tamen deorum'**
  String get aboutUsHelpContent;

  /// The description of the info button
  ///
  /// In en, this message translates to:
  /// **'info'**
  String get aboutUsInfoButton;

  /// The about us info content
  ///
  /// In en, this message translates to:
  /// **'# Numinis donis\n\nIsta nunc alieni, sine odium? Clamor fugit.\n\nInmotaeque ad sine Nec celebres, quamvis in virtus tempore\n[Colchi](http://inmissa.io/mater), voce finditque. Humo exceptas quocumque suo\nLemnos vidi, nec Anguemque, Ancaei mater. Sua arte querellis infice nato sum\nNoricus inque, sed *carmina rapta* sensit visa, **in hostes** repercusso.\nProfundum suum reor *aequorei*; plus fraxinus oscula aures, quae.'**
  String get aboutUsInfoContent;

  /// The description of the press button
  ///
  /// In en, this message translates to:
  /// **'press'**
  String get aboutUsPressButton;

  /// The about us press content
  ///
  /// In en, this message translates to:
  /// **'# Celeberrima Herculeae hic ego mutatis adhuc adesse\n\n## Sanguine frustra frementi\n\nLorem markdownum liquidis sua parte clamabat: corpora Musae arbore sed quoque.\nSim venit mihi: qua exemplum in procul! Tu levat **caruisse**? Deo me supplice\nvidit aperire currebam; et vidit tuaque; telis cape?\n\n1. In iussis verbere non manibus in dicitur\n2. Felle motura numina reserato utque formidine turbatum\n3. Huc volucris harena haerentes in antro ad\n4. Modo cinnama fecere finierat sed maerenti salutis\n\nEt vias desierim, dant *leges* sparsisque, dum vulnus!\n[Aequoreo](http://www.munera-iter.org/dixit-domo.html) est! Per precor *negarit*\nturbata nunc. Sudataque amor Pyrrha erat *posuisse* et Pelea parvum, cum Cnidon.\n**Corpore** ora pavet ego putas merentem requiemque vires.\n\n## Haud dicunt validos in non iacentes ademit\n\nEt eius forte sus tibi verba qui longum sceptri lenta. Recenti ardentibus:\ncaputque laevaque quinta nectar vulnera, sine pennis hostes lanas colantur.\nVirgine utile domus.\n\nPostquam indeiecta, sed lateri lusus victor, ubi, caespite, et primum hominem,\ncopia? Memor arcum poscis matrem.'**
  String get aboutUsPressContent;

  /// The description of the privacy button
  ///
  /// In en, this message translates to:
  /// **'privacy'**
  String get aboutUsPrivacyButton;

  /// The about us privacy content
  ///
  /// In en, this message translates to:
  /// **'# Adverso dixi\n\n## Promittere etsi timens scilicet rerumque adiit\n\nLorem markdownum mille. A ferox Echo sic **posuitque alimenta gradibus** at\ntransit praesignis reddunt Eleleusque Dolopum; vigor.\n\n> Nunc rapta: nomina vasta Anchises **Orpheu temeraria** volubile, male nondum\n> fremit edidit, **ducem**? Auro et domino, potius propioris Lyctia. Lumen **et\n> cubitoque**, conubia tauri ingratumque ultima, cervice nobis positis omnibus\n> est sinistro Rhesi genetrix dicenti. Fluviumque\n> [aut](http://cui.org/iam.html), collibus avenis utilis ne excita pictas aurum\n> paventem pretium graviore, inerti legebantur minis delubris, vos.'**
  String get aboutUsPrivacyContent;

  /// The description of the terms button
  ///
  /// In en, this message translates to:
  /// **'terms'**
  String get aboutUsTermsButton;

  /// The about us terms content
  ///
  /// In en, this message translates to:
  /// **'# His quo levati comantem ferro percussis ense\n\n## Unguibus sed\n\nLorem markdownum Cepheusque faciem cecidisti, triplici quod, non. Posuere non\nnactus ingemis ut puppe eiusdem, pertimuit **quod** terram et venit inpune,\n*carent* valvis per! Quae verba obiecit nostri, ire *Galanthis conciderant tu*\nmaterna calamo; arte nunc litatis terrae et alii. Supplicium iuvenem abditus\navium, posito ignis dixit nocens, facienda Rhodanumque! Docta quas movebatur\nquid, fuerunt undas dum **altera**, aliquo.\n\n- Solet verba Magnetas sinuatoque et cervos inane\n- Ingratus morando\n- Et Phaethon in levia parentem\n\n## Non cum vobis animos venit\n\nSed venae tamen imperio quibus ab callidus cadendum sparsisque ut veteris vellet\nadcubuere! Mensura sonat me sortemque Eumenidum Liriope; nunc clavae infelix\nvesci constant usu tellus victam illa: erant sed? Vis omnes ascendere capillos\ndeorum modo oculos modusque *arma* optet foret et, umbrosum inquit?\n\n## Luna tantum is verba remansit tosti deciderant\n\nIam Pallante in per sopor vitta paene: otia inde laesum dextra quae. Et mea\nrediit futurus: ope vera dicens ad sua dixi honore pater! Ponit quo quoque\nedere; deposcunt quis **barbae tuae** inquit optas et pepercit sanctis adice fer\nredituram frustra orbem sive. Vitiato alta [nec illi\negregius](http://www.locis.org/cumexitus) Aegaeas nulli, *optime* est lacus\ncepit **utque nec** caerula.\n\n> Est gemini; Hymenaeus siccis. *Iuno aquis* adamas nemorum pomaque in\n> **incurrere subita** testarique et pennaeque.\n\n## Et ille quem verterat vultibus urguet ille\n\nVocis spectabilis velamina cum vires quae. Nunc aliter resistunt referre roganti\narcet, fingetur et saepe pendebat fortiter vos.\n\n1. Mopso fert silva\n2. Amplexumque anum\n3. Citra aera lumen fumant Tatiumque altaribus celebrare'**
  String get aboutUsTermsContent;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
