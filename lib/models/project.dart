class Project {
  final String title;
  final String subtitle;
  final String bannerImage;
  final String category; // "UI/UX", "Web", "Mobile"
  final String description;
  final String problem;
  final String solution;
  final String githubLink;
  final String? liveLink;
  final List<String>? gallery;

  Project({
    required this.title,
    required this.subtitle,
    required this.bannerImage,
    required this.category,
    required this.description,
    required this.problem,
    required this.solution,
    required this.githubLink,
    this.liveLink,
    this.gallery,
  });
}
