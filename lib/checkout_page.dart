import 'package:flutter/material.dart';
import 'classes_and_methods/package.dart';
import 'classes_and_methods/user.dart';
import 'carrier_page.dart';

// Add dispose function to all the widget, since this page is eating up memory.

class CheckOutPage extends StatefulWidget {
  CheckOutPage(
      {Key key, this.package, @required this.previousPackage, this.user})
      : super(key: key);
  final bool previousPackage;
  final Package package;
  final User user;

  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Package _package = new Package();

  @override
  void initState() {
    super.initState();
    if (widget.previousPackage) {
      _package.width = widget.package.width;
      _package.height = widget.package.height;
      _package.length = widget.package.length;
      _package.weight = widget.package.weight;
      _package.sender = widget.package.sender;
      _package.destination = widget.package.destination;
      _package.phone = widget.package.phone;
    } else {
      print(widget.package.width);
      _package.width = widget.package.width;
      _package.height = widget.package.height;
      _package.length = widget.package.length;
      _package.sender = new Address();
      _package.destination = new Address();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updatePackageDimensions(Package package) {
    setState(() {
      _package.width = package.width;
      _package.height = package.height;
      _package.length = package.length;
      _package.weight = package.weight;
    });
  }

  void _updatePackageSenderAddress(Package package) {
    setState(() {
      _package.sender = package.sender;
    });
  }

  void _updatePackageDestinationrAddress(Package package) {
    setState(() {
      _package.destination = package.destination;
    });
  }

  void _updateContactNumber(String phone) {
    setState(() {
      _package.phone = phone;
    });
  }

  bool _checkDimensions() {
    if (_package.width != null &&
        _package.height != null &&
        _package.length != null &&
        _package.weight != null) {
      return true;
    }
    return false;
  }

  bool _checkSenderAddress() {
    if (_package.sender.name != null &&
        _package.sender.street1 != null &&
        _package.sender.city != null &&
        _package.sender.state != null &&
        _package.sender.country != null) {
      return true;
    }
    return false;
  }

  bool _checkDestinationAddress() {
    if (_package.destination.name != null &&
        _package.destination.street1 != null &&
        _package.destination.city != null &&
        _package.destination.state != null &&
        _package.destination.country != null) {
      return true;
    }
    return false;
  }

  bool _checkPhone() {
    if (_package.phone != null) {
      return true;
    }
    return false;
  }

  Route _confirmSubmit() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => CarrierPage(
        package: _package,
        user: widget.user,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var packageComplete;
    if (_checkDimensions() &&
        _checkSenderAddress() &&
        _checkDestinationAddress() &&
        _checkPhone()) {
      packageComplete = true;
    } else {
      packageComplete = false;
    }

    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          actions: packageComplete
              ? [
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Colors.white,
                    onPressed: () =>
                        Navigator.of(context).push(_confirmSubmit()),
                  )
                ]
              : null,
          bottom: TabBar(
            isScrollable: true,
            tabs: choices.map((Choice choice) {
              return Tab(
                text: choice.title,
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ChoiceCard(
                choice: choice,
                package: _package,
                previousPackage: widget.previousPackage,
                updatePacakgeDimensions: _updatePackageDimensions,
                updateSenderAddress: _updatePackageSenderAddress,
                updateDestinationAddress: _updatePackageDestinationrAddress,
                updateContactNumber: _updateContactNumber,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title});
  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Dimensions'),
  const Choice(title: 'Source'),
  const Choice(title: 'Destination'),
  const Choice(title: 'Contact')
];

class ChoiceCard extends StatefulWidget {
  const ChoiceCard(
      {Key key,
      this.choice,
      this.package,
      this.previousPackage,
      this.updatePacakgeDimensions,
      this.updateSenderAddress,
      this.updateDestinationAddress,
      this.updateContactNumber})
      : super(key: key);

  final Choice choice;
  final bool previousPackage;
  final Package package;
  final Function(Package) updatePacakgeDimensions;
  final Function(Package) updateSenderAddress;
  final Function(Package) updateDestinationAddress;
  final Function(String) updateContactNumber;

  _ChoiceCardState createState() => _ChoiceCardState();
}

class _ChoiceCardState extends State<ChoiceCard> {
  Package _package = new Package();
  bool packageComplete;
  @override
  void initState() {
    super.initState();
    _package.width = widget.package.width;
    _package.height = widget.package.height;
    _package.length = widget.package.length;
    _package.weight = widget.package.weight;
    _package.sender = widget.package.sender;
    _package.destination = widget.package.destination;
    _package.phone = widget.package.phone;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _chooseCheckoutPage(String title) {
    switch (title) {
      case 'Dimensions':
        return DimensionsCard(
          package: _package,
          previousPackage: widget.previousPackage,
          updatePacakgeDimensions: widget.updatePacakgeDimensions,
        );
      case 'Source':
        return SourceAddressCard(
          package: _package,
          previousPackage: widget.previousPackage,
          updateSenderAddress: widget.updateSenderAddress,
        );
      case 'Destination':
        return DestinationAddressCard(
          package: _package,
          previousPackage: widget.previousPackage,
          updateDestinationAddress: widget.updateDestinationAddress,
        );
      case 'Contact':
        return ContactCard(
          package: _package,
          previousPackage: widget.previousPackage,
          updateContactNumber: widget.updateContactNumber,
        );
      default:
        return Text('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Center(child: _chooseCheckoutPage(widget.choice.title)));
  }
}

class DimensionsCard extends StatefulWidget {
  DimensionsCard({
    Key key,
    this.package,
    this.previousPackage,
    this.updatePacakgeDimensions,
  }) : super(key: key);

  final Function(Package) updatePacakgeDimensions;
  final Package package;
  final bool previousPackage;
  _DimensionsCardState createState() => _DimensionsCardState();
}

class _DimensionsCardState extends State<DimensionsCard> {
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  final _lengthController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _widthController.text = widget.package.width == null
        ? null
        : widget.package.width.toStringAsFixed(2);
    _heightController.text = widget.package.height == null
        ? null
        : widget.package.height.toStringAsFixed(2);
    _lengthController.text = widget.package.length == null
        ? null
        : widget.package.length.toStringAsFixed(2);
    _weightController.text = widget.package.weight == null
        ? null
        : widget.package.weight.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    _lengthController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _updateDimension() {
    widget.updatePacakgeDimensions(new Package(
        width: _widthController.text.isEmpty
            ? null
            : double.parse(_widthController.text),
        height: _heightController.text.isEmpty
            ? null
            : double.parse(_heightController.text),
        length: _lengthController.text.isEmpty
            ? null
            : double.parse(_lengthController.text),
        weight: _weightController.text.isEmpty
            ? null
            : double.parse(_weightController.text)));
  }

  @override
  Widget build(BuildContext context) {
    final widthTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Width (cm)",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Width (cm)',
        errorText:
            _widthController.text.isEmpty ? "Please enter the width!" : null,
      ),
      controller: _widthController,
    );
    _widthController.addListener(_updateDimension);

    final heightTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Height (cm)",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Height (cm)',
        errorText:
            _heightController.text.isEmpty ? "Please enter the height!" : null,
      ),
      controller: _heightController,
    );
    _heightController.addListener(_updateDimension);

    final lengthTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Length (cm)",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Length (cm)',
        errorText:
            _lengthController.text.isEmpty ? "Please enter the length!" : null,
      ),
      controller: _lengthController,
    );
    _lengthController.addListener(_updateDimension);

    final weightTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Weight (lbs)",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Weight (lbs)',
        errorText:
            _weightController.text.isEmpty ? "Please enter the weight!" : null,
      ),
      controller: _weightController,
    );
    _weightController.addListener(_updateDimension);

    return Padding(
        padding: const EdgeInsets.all(36.0),
        child: ListView(
          children: [
            widthTextBox,
            heightTextBox,
            lengthTextBox,
            weightTextBox,
          ],
        ));
  }
}

class SourceAddressCard extends StatefulWidget {
  SourceAddressCard(
      {Key key, this.package, this.previousPackage, this.updateSenderAddress})
      : super(key: key);
  final Function(Package) updateSenderAddress;
  final Package package;
  final bool previousPackage;

  @override
  _SourceAddressCardState createState() => _SourceAddressCardState();
}

class _SourceAddressCardState extends State<SourceAddressCard> {
  final _nameController = TextEditingController();
  final _street1Controller = TextEditingController();
  final _street2Controller = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.package.sender.name;
    _street1Controller.text = widget.package.sender.street1;
    _street2Controller.text = widget.package.sender.street2;
    _stateController.text = widget.package.sender.state;
    _cityController.text = widget.package.sender.city;
    _countryController.text = widget.package.sender.country;
    _zipController.text = widget.package.sender.zip.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _street1Controller.dispose();
    _street2Controller.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _updateSenderAddress() {
    widget.updateSenderAddress(new Package(
        sender: new Address(
            name: _nameController.text.isEmpty ? null : _nameController.text,
            street1: _street1Controller.text.isEmpty
                ? null
                : _street1Controller.text,
            state: _stateController.text.isEmpty ? null : _stateController.text,
            city: _cityController.text.isEmpty ? null : _cityController.text,
            country: _countryController.text.isEmpty
                ? null
                : _countryController.text,
            street2:
                _street2Controller.text.isEmpty ? ' ' : _street2Controller.text,
            zip: _zipController.text.isEmpty ? null : _zipController.text)));
  }

  @override
  Widget build(BuildContext context) {
    final _nameTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Source Name",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Source Name',
        errorText: _nameController.text.isEmpty
            ? "Please enter the source name!"
            : null,
      ),
      controller: _nameController,
    );

    final _street1TextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Source Street Address",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Source Street Address',
        errorText: _street1Controller.text.isEmpty
            ? "Please enter the source street!"
            : null,
      ),
      controller: _street1Controller,
    );

    final _street2TextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Source Street Address",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Source Street Address',
        errorText: _street2Controller.text.isEmpty
            ? "Please enter the source street!"
            : null,
      ),
      controller: _street2Controller,
    );

    final _cityTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Source City",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Source City',
        errorText: _cityController.text.isEmpty
            ? "Please enter the source city!"
            : null,
      ),
      controller: _cityController,
    );

    final _stateTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Source State",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Source State',
        errorText: _stateController.text.isEmpty
            ? "Please enter the source state"
            : null,
      ),
      controller: _stateController,
    );

    final _countryTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
          hintText: "Source Country",
          contentPadding: EdgeInsets.all(10.0),
          labelText: 'Source Country',
          errorText: _countryController.text.isEmpty
              ? "Please enter the source country"
              : null),
      controller: _countryController,
    );

    final _zipTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
          hintText: "Source Zip Code",
          contentPadding: EdgeInsets.all(10.0),
          labelText: 'Source Zip Code',
          errorText: _zipController.text.isEmpty
              ? "Please enter the source zip code"
              : null),
      controller: _zipController,
    );

    _nameController.addListener(_updateSenderAddress);
    _street1Controller.addListener(_updateSenderAddress);
    _street2Controller.addListener(_updateSenderAddress);
    _stateController.addListener(_updateSenderAddress);
    _cityController.addListener(_updateSenderAddress);
    _countryController.addListener(_updateSenderAddress);
    _zipController.addListener(_updateSenderAddress);

    return Padding(
        padding: const EdgeInsets.all(36.0),
        child: ListView(
          children: [
            _nameTextBox,
            _street1TextBox,
            _street2TextBox,
            _cityTextBox,
            _stateTextBox,
            _countryTextBox,
            _zipTextBox
          ],
        ));
  }
}

class DestinationAddressCard extends StatefulWidget {
  DestinationAddressCard(
      {Key key,
      this.package,
      this.previousPackage,
      this.updateDestinationAddress})
      : super(key: key);
  final Function(Package) updateDestinationAddress;
  final Package package;
  final bool previousPackage;
  @override
  _DestinationAddressCardState createState() => _DestinationAddressCardState();
}

class _DestinationAddressCardState extends State<DestinationAddressCard> {
  final _nameController = TextEditingController();
  final _street1Controller = TextEditingController();
  final _street2Controller = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.package.destination.name;
    _street1Controller.text = widget.package.destination.street1;
    _street2Controller.text = widget.package.destination.street2;
    _stateController.text = widget.package.destination.state;
    _cityController.text = widget.package.destination.city;
    _countryController.text = widget.package.destination.country;
    _zipController.text = widget.package.destination.zip.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _street1Controller.dispose();
    _street2Controller.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _updateDestinationAddress() {
    widget.updateDestinationAddress(new Package(
        destination: new Address(
            name: _nameController.text.isEmpty ? null : _nameController.text,
            street1: _street1Controller.text.isEmpty
                ? null
                : _street1Controller.text,
            state: _stateController.text.isEmpty ? null : _stateController.text,
            city: _cityController.text.isEmpty ? null : _cityController.text,
            country: _countryController.text.isEmpty
                ? null
                : _countryController.text,
            street2:
                _street2Controller.text.isEmpty ? ' ' : _street2Controller.text,
            zip: _zipController.text.isEmpty ? null : _zipController.text)));
  }

  @override
  Widget build(BuildContext context) {
    final _nameTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Destination Name",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Destination Name',
        errorText: _nameController.text.isEmpty
            ? "Please enter the destination name!"
            : null,
      ),
      controller: _nameController,
    );

    final _street1TextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Destination Street Address",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Destination Street Address',
        errorText: _street1Controller.text.isEmpty
            ? "Please enter the destination street!"
            : null,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter the destination street address!';
        }
        return null;
      },
      controller: _street1Controller,
    );

    final _street2TextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Destination Street Address",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Destination Street Address',
        errorText: _street2Controller.text.isEmpty
            ? "Please enter the destination street!"
            : null,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter the destination street address!';
        }
        return null;
      },
      controller: _street2Controller,
    );

    final _cityTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Destination City",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Destination City',
        errorText: _cityController.text.isEmpty
            ? "Please enter the destination city!"
            : null,
      ),
      controller: _cityController,
    );

    final _stateTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Destination State",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Destination State',
        errorText: _stateController.text.isEmpty
            ? "Please enter the destination state"
            : null,
      ),
      controller: _stateController,
    );

    final _countryTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Destination Country",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Destination Country',
        errorText: _countryController.text.isEmpty
            ? "Please enter the destination country!"
            : null,
      ),
      controller: _countryController,
    );

    final _zipTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
          hintText: "Destination Zip Code",
          contentPadding: EdgeInsets.all(10.0),
          labelText: 'Destination Zip Code',
          errorText: _zipController.text.isEmpty
              ? "Please enter the destination zip code"
              : null),
      controller: _zipController,
    );

    _nameController.addListener(_updateDestinationAddress);
    _street1Controller.addListener(_updateDestinationAddress);
    _street2Controller.addListener(_updateDestinationAddress);
    _stateController.addListener(_updateDestinationAddress);
    _cityController.addListener(_updateDestinationAddress);
    _countryController.addListener(_updateDestinationAddress);
    _zipController.addListener(_updateDestinationAddress);

    return Padding(
        padding: const EdgeInsets.all(36.0),
        child: ListView(
          children: [
            _nameTextBox,
            _street1TextBox,
            _street2TextBox,
            _cityTextBox,
            _stateTextBox,
            _countryTextBox,
            _zipTextBox,
          ],
        ));
  }
}

class ContactCard extends StatefulWidget {
  ContactCard({
    Key key,
    this.package,
    this.previousPackage,
    this.updateContactNumber,
  }) : super(key: key);

  final Function(String) updateContactNumber;
  final Package package;
  final bool previousPackage;
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.package.phone;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _updateContactNumber() {
    widget.updateContactNumber(
        _phoneController.text.isEmpty ? null : _phoneController.text);
  }

  @override
  Widget build(BuildContext context) {
    final _phoneTextBox = TextFormField(
      obscureText: false,
      decoration: InputDecoration(
        hintText: "Phone",
        contentPadding: EdgeInsets.all(10.0),
        labelText: 'Phone',
        errorText: _phoneController.text.isEmpty
            ? "Please enter the contact phone number!"
            : null,
      ),
      controller: _phoneController,
    );

    _phoneController.addListener(_updateContactNumber);

    return Padding(
        padding: const EdgeInsets.all(36.0),
        child: ListView(
          children: [
            _phoneTextBox,
          ],
        ));
  }
}
