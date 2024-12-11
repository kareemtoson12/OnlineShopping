import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shopping/core/routing/app_routes.dart';
import 'package:online_shopping/core/styles/customs_colors.dart';
import 'package:online_shopping/core/styles/styles.dart';

class TransactionsReportPage extends StatefulWidget {
  const TransactionsReportPage({Key? key}) : super(key: key);

  @override
  _TransactionsReportPageState createState() => _TransactionsReportPageState();
}

class _TransactionsReportPageState extends State<TransactionsReportPage> {
  DateTime? selectedDate;
  List<Map<String, dynamic>> transactions = [];
  bool isLoading = false;

  Future<void> fetchTransactions() async {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final startOfDay = Timestamp.fromDate(
        DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day),
      );
      final endOfDay = Timestamp.fromDate(
        DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day, 23,
            59, 59),
      );

      final querySnapshot = await FirebaseFirestore.instance
          .collection('Transaction')
          .where('timestamp', isGreaterThanOrEqualTo: startOfDay)
          .where('timestamp', isLessThanOrEqualTo: endOfDay)
          .get();

      setState(() {
        transactions = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch transactions: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        transactions = []; // Clear previous transactions
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95.0.dg,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.adminfunctionality);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomsColros.primaryColor,
        title: Text(
          'Transaction',
          style: AppTextStyles.font30blackTitle.copyWith(fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    pickDate();
                  },
                  child: Container(
                    width: 150.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: CustomsColros.primaryColor),
                    child: Center(
                      child: Text(
                        'pick A Date',
                        style: AppTextStyles.font25blacSubTitle,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    fetchTransactions();
                  },
                  child: Container(
                    width: 150.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: CustomsColros.primaryColor),
                    child: Center(
                      child: Text(
                        'pick A Date',
                        style: AppTextStyles.font25blacSubTitle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : transactions.isEmpty
                    ? const Center(child: Text('No transactions found.'))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = transactions[index];
                            return Card(
                              color: CustomsColros.offPrimaryColor,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Transaction ID: ${transaction['transactionId']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text('User ID: ${transaction['userId']}'),
                                    const SizedBox(height: 5),
                                    Text('Amount: \$${transaction['amount']}'),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Timestamp: ${transaction['timestamp'].toDate()}',
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Details:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ...((transaction['details'] as List)
                                        .map((item) => Text(
                                              '- ${item['name']} (x${item['quantity']}): \$${item['price']}',
                                            ))),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
