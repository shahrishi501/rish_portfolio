import 'package:flutter/material.dart';

class ProjectPageWidget extends StatelessWidget {
  const ProjectPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return ListView(
      shrinkWrap: true,
      children: [ProjectCard(w: w), ProjectCard(w: w)],
    );
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.w});

  final double w;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          height: w * 0.7,
          width: w * 0.9,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(
                  "assets/img/background.jpg", // widget.response.featuredImage ?? ''
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                //   Padding(
                //     padding: EdgeInsets.only(left: w * 0.8, top: 15),
                //     child: GestureDetector(
                //       onTap: () => loginStatus
                //           ? _toggleFavorite()
                //           : showLoginDialog(context, 'Please login to add to favorites!!'),
                //       child: Container(
                //         height: h * 0.042,
                //         width: w * 0.09,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(38),
                //           color: Colors.white,
                //         ),
                //         child: Icon(
                //           isFavorite ? Icons.favorite : Icons.favorite_border,
                //           color: isFavorite ? Colors.red : Colors.black,
                //           size: 22,
                //         ),
                //       ),
                //     ),
                //   ),
                //  widget.response.isPromoted == true ?
                //  Positioned(
                //   left: 12,
                //   top: 15,
                //    child: Container(
                //       height: h * 0.032,
                //       width: w * 0.2,
                //       decoration: BoxDecoration(
                //         color: AppColors.red,
                //         borderRadius: BorderRadius.circular(7)
                //       ),
                //       child: Center(
                //         child: Text("Promoted", style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 11,
                //           fontWeight: FontWeight.bold,
                //           fontFamily: "popsB",
                //         ), textAlign: TextAlign.center,),
                //       ),
                //    ),
                //  )
                //  : Container(),
                Positioned(
                  bottom: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: w * 0.93,
                        margin: const EdgeInsets.only(left: 12, right: 12),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: w * 0.68,
                                    child: Text(
                                      "Noteng",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "popR",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: w * 0.65,
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "popR",
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (true)
                                    Text(
                                      " mi",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "popR",
                                      ),
                                    ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "popR",
                                    ),
                                  ),
                                  Text(
                                    " avg price",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "popR",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
