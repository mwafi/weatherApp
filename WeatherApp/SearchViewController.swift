//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Mohammed Hassanien on 17/04/2026.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
class SearchViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MKMapViewDelegate
{
    @IBOutlet weak var resultContainerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    let dummyData = [
            (city: "Surabaya", temp: "34° / 23°"),
            (city: "Banjarmasin", temp: "30° / 21°"),
            (city: "Yogyakarta", temp: "32° / 21°")
        ]

        override func viewDidLoad() {
            super.viewDidLoad()

            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.rowHeight = 60
            
            // 1. المهم هنا: نخفي الـ Container كله مش الجدول بس
            resultContainerView.isHidden = true
            resultContainerView.layer.cornerRadius = 20 // اختياري لشكل أشيك
            
            searchTextField.delegate = self
            mapView.delegate = self

            setupSearchBox()

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
            mapView.addGestureRecognizer(tapGesture)

            searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }

        func setupSearchBox() {
            searchView.backgroundColor = .white
            searchView.layer.cornerRadius = 25
            searchView.layer.shadowColor = UIColor.black.cgColor
            searchView.layer.shadowOpacity = 0.08
            searchView.layer.shadowOffset = CGSize(width: 0, height: 5)
            searchView.layer.shadowRadius = 10
            searchView.layer.masksToBounds = false
        }

        // MARK: - UITableViewDataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dummyData.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchCell", for: indexPath) as! RecentSearchCell
            let city = dummyData[indexPath.row]
            cell.cityNameLabel.text = city.city
            cell.tempLabel.text = city.temp
            return cell
        }

        // MARK: - Search Behavior
        
        // الدالة دي بتشتغل أول ما تلمسي الـ TextField
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            // إظهار النتائج بحركة ناعمة
            UIView.animate(withDuration: 0.3) {
                self.resultContainerView.isHidden = false
            }
            return true
        }

        @objc func textFieldDidChange(_ textField: UITextField) {
            let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            // لو النص فاضي، ممكن تخفي النتائج تاني أو تسيبيها (حسب ذوقك)
            // هنا هنخليها تظهر دايماً طالما المستخدم بيعدل
            resultContainerView.isHidden = false
            tableView.reloadData()
        }

        // MARK: - Map Tap
        @objc func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
            view.endEditing(true) // يقفل الكيبورد
            
            // إخفاء النتائج لما نضغط على الخريطة عشان نشوف المكان المختار
            UIView.animate(withDuration: 0.3) {
                self.resultContainerView.isHidden = true
            }
            
            // كود وضع العلامة على الخريطة (بتاعك زي ما هو)
            let locationInView = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            mapView.removeAnnotations(mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Selected Location"
            mapView.addAnnotation(annotation)
        }
    }
