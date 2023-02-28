import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner/src/scanner_overlay.dart';

class QrCodeScannerScreen extends StatefulWidget {
  const QrCodeScannerScreen({super.key});

  @override
  State<QrCodeScannerScreen> createState() => _QrCodeScannerScreenState();
}

class _QrCodeScannerScreenState extends State<QrCodeScannerScreen> {
  MobileScannerController controller = MobileScannerController(
    torchEnabled: true,
  );
  BarcodeCapture? barcodeCapture;
  bool _isStarted = true;
  double _zoomFactor = 0.0;

  Rect get scanWindow => Rect.fromCenter(
        center: MediaQuery.of(context).size.center(Offset.zero),
        width: 200,
        height: 200,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: trout,
      body: SafeArea(
        child: Stack(
          children: [
            MobileScanner(
              controller: controller,
              fit: BoxFit.contain,
              onDetect: (barcodeCapture) {
                setState(() {
                  this.barcodeCapture = barcodeCapture;
                });
              },
            ),
            CustomPaint(
              painter: ScannerOverlay(scanWindow),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 100,
                child: Column(
                  children: [
                    Slider(
                      value: _zoomFactor,
                      onChanged: (value) {
                        setState(() {
                          _zoomFactor = value;
                          controller.setZoomScale(value);
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          color: white,
                          icon: ValueListenableBuilder(
                            valueListenable: controller.torchState,
                            builder: (context, state, child) {
                              switch (state) {
                                case TorchState.off:
                                  return const Icon(
                                    Icons.flash_off,
                                    color: santasGray10,
                                  );
                                case TorchState.on:
                                  return const Icon(
                                    Icons.flash_on,
                                    color: Colors.yellow,
                                  );
                              }
                            },
                          ),
                          iconSize: 32,
                          onPressed: () => controller.toggleTorch(),
                        ),
                        IconButton(
                          color: white,
                          icon: _isStarted
                              ? const Icon(Icons.stop)
                              : const Icon(Icons.play_arrow),
                          iconSize: 32,
                          onPressed: () {
                            setState(() {
                              _isStarted
                                  ? controller.stop()
                                  : controller.start();
                              _isStarted = !_isStarted;
                            });
                          },
                        ),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 200,
                            height: 50,
                            child: FittedBox(
                              child: Text(
                                barcodeCapture?.barcodes.first.rawValue ??
                                    'Scan Address!',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: FontSize.mediumLarge,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          color: white,
                          icon: ValueListenableBuilder(
                            valueListenable: controller.cameraFacingState,
                            builder: (context, state, child) {
                              switch (state) {
                                case CameraFacing.front:
                                  return const Icon(Icons.camera_front);
                                case CameraFacing.back:
                                  return const Icon(Icons.camera_rear);
                              }
                            },
                          ),
                          iconSize: 32,
                          onPressed: () => controller.switchCamera(),
                        ),
                        IconButton(
                          color: white,
                          icon: const Icon(Icons.image),
                          iconSize: 32,
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (image != null) {
                              if (await controller.analyzeImage(image.path)) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Barcode found!'),
                                    backgroundColor: carribeanGreen,
                                  ),
                                );
                              } else {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('No barcode found!'),
                                    backgroundColor: flamingo,
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width / 2,
                child: ExpandedElevatedButton(
                  label: 'Done',
                  onTap: () {
                    final address = barcodeCapture?.barcodes.first.rawValue;
                    Navigator.of(context).pop(address);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
