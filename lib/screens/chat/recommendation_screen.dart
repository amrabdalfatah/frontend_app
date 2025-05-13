import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fashion_app/providers/stylist_provider.dart';
import 'package:fashion_app/widgets/product_card.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendation =
        context.watch<StylistProvider>().currentRecommendation;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Recommendation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareRecommendation(context),
          ),
        ],
      ),
      body:
          recommendation == null
              ? const Center(child: Text('No recommendations yet'))
              : Column(
                children: [
                  // Recommendation Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Stylist Recommendation',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          recommendation.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),

                  // Products Grid
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.7,
                            ),
                        itemCount: recommendation.products.length,
                        itemBuilder: (context, index) {
                          final product = recommendation.products[index];
                          return ProductCard(product: product);
                        },
                      ),
                    ),
                  ),
                ],
              ),
    );
  }

  void _shareRecommendation(BuildContext context) {
    final recommendation =
        context.read<StylistProvider>().currentRecommendation;
    if (recommendation == null) return;

    // Implement your sharing logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sharing this recommendation...')),
    );
  }
}
