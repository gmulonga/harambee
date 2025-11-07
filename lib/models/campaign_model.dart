class Campaign {
  int id;
  String title;
  String description;
  double targetAmount;
  double amountRaised;

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.amountRaised,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'target_amount': targetAmount,
    'amount_raised': amountRaised,
  };

  factory Campaign.fromMap(Map<String, dynamic> map) => Campaign(
    id: map['id'],
    title: map['title'],
    description: map['description'],
    targetAmount: map['target_amount'],
    amountRaised: map['amount_raised'],
  );
}
