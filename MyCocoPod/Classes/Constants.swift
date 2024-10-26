//
//  Constants.swift
//  Salamtak PatientApp
//
//  Created by Es on 1/29/20.
//  Copyright © 2020 Es. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardsConstants: String {
    //MARK: New ADVA APP
    case Main
    case Services
    case Category // for all services that have category
    case ImportantInfoSheetVC
    case Operations
    case Profile
    case Offers
    case Home
    case AdvaHome
    case Booking
    case ComingSoon
    case Notifications
    case More
    case OnBoarding
    case LottieProgress
    case ForgotPassword
    case EmptyState
    case Reviews
    case Cancel
    case FilterBottomSheet
    case Providers
    case RequestOperation
    case FinancialInfo
    case FinancialInformation
    case Filter
    case Search
    case Insurance
    case Education
    case EduInstitutes
    case Soon
    case AmanInstDetails
    case Wedding
    case PremiumCard
    case Finishing
    case CustomFinishing
    case CarService
    case CustomCar
    case FinishingService
    case Requests
    case Bill
    case Travel
    case Others
    case EducationCatalogue
    case EduSchool
    case EduCourses
    case EduUniversity
    case EduCustom
    case WeddingCustom
    case ReferalVC
    case CheckMe
    //MARK: New Financial Profile
    case FP_OCR
    case FinancialProfileStepOne
    case FinancialProfileStepThree
    case FinancialProfileStepFour
    case FinancialProfileStepFive
    case FPViewSteps
    case FinishFP
    case FinancialRequestDetails
    case Installments
    case PaymentFlow

    case Payment
    case PaymentList
    func getStoryboardInstance() -> UIStoryboard {
        switch self {
        default:
            return UIStoryboard.init(name: self.rawValue, bundle: nil)
        }
    }
    
    func getViewControllerInstance(identifier: String) -> UIViewController {
        switch self {
        default:
            return UIStoryboard.init(name: self.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier)
        }
    }
    
}

enum HomeEnum: String {
    case FP
    case Request
    
}

enum ButtonFRType{
    case cancel
    case refund
}

enum ShareViewToHide: Int {
    case First
    case Second
    case Share
}

enum EducationCategoryTypeEnum: Int {
    case School = 1
    case University
    case Institute
    case CustomEducationRequest
    case Courses
}

enum FinishingContactType: Int, Codable {
    case Facebook = 1
    case Instagram
    case Website
    case Email
    case Phone
    case Mobile
}

enum AuthErrorEnum:Int,Codable{
    case SocialError = 1
    case NormalError
    case NotVerfify
    case DeletedUser
    case DeactivatedUser
    case Emailalreadyused
    case UsernameAlreadyUsed
    case Phonealreadyused
    case SocialAccountAlreadyused
}

enum MainCategoriesEnum: Int, Codable {
    case Health = 1
    case Education
    case Insurance
    case GYM
    case Wedding
    case Others
    case Car
    case Finishing
    case Travel
    case BillPayment
}
enum BookingTypesEnum: Int, Codable {
    case Health = 1
    case Education
    case Insurance
    case Wedding
    case Car
    case Finishing
    case Bill
    case Travel
    case Other
}
enum ADVAModulesEnum :Int, Codable {
   case Services = 1
   case FinancialProfile
   case Favorite
   case Cart
}
enum InstallmentLoockUpTypeEnum: Int,Codable{
  case Health = 1
  case Education
  case Insurance
  case GYM
  case Wedding
  case Others
  case Car
  case Finishing
  case Travel
  case BillPayment
}
enum InstallmentEquation: Int,Codable {
    case equation1 = 1
    case equation2
}
enum ContactType: Int, Codable {
    case Facebook = 1
    case Instagram
    case Website
    case Email
    case Phone
    case Mobile
    case Social
    case Fax
}
//MARK: EDU
//new
enum CategoryTypeEnum:Int,Codable {
    case School = 1
    case University
    case Institute
    case Others
    case Courses
    case Othercategory
    
}

enum ServiceTypeEnum:Int,Codable{
    case HEALTH = 1
    case EDUCATION
    case INSURANCE
    case WEDDING
    case CARS
    case FINISHING
    case BILL
    case TRAVEL
    case OTHERS
}

enum EducationServiceType:Int,Codable{
    case University = 1
    case Institute
    case School
    case COURSES
}

enum SERVICEPROVIDERCATEGORY:String,Codable{
    case NONE = "0"
    case WEDDING = "1"
    case CARSERVICE = "2"
    case FINISHINGSERVICE = "3"
    case MEDICAL = "4"
    case DOCTORS = "5"
    case COURSES = "6"
    case UNIVERSITYANDINSTITUES = "7"
    case SCHOOLS = "8"
    case TRAVEL = "9"
    case INSURANCE = "10"
    case BILL = "11"
    case OTHER = "12"
}

enum OperationOwner:Int,Codable {
    case defualt = 0
    case Doctor
    case MedicalProvider
}

enum WeddingDetailsType: Int, Codable {
    case Package = 1
    case Product
    case NONE
}
enum FromPage{
    case Search
    case Filter
    case ViewAll
}

enum TravelDetailsType: Int, Codable {
    case Package = 1
    case Product
    case NONE
}

enum TravelType: Int, Codable{
    case travelTypeNil = 0
    case Abroad = 1
    case Local = 2
    case Both = 3
}

enum TravelAllType: Int, Codable{
    case TravelAgency = 1
    case Hotel = 2
}

enum InsuranceCompanyType:Int,Codable{
    case Broker = 1
    case InsuranceCompany
}

enum BookingStatusEnum: Int {
    case PENDING = 0
    case PROCESSING
    case FINANCIAL_REVIEWING
    case FINANCIAL_APPROVED
    case MEDICAL_APPROVED
    case HAS_PROBLEM
    case DONE
    case FINANCIAL_REJECT
    case MEDICAL_REJECT
    case PENDING_FOR_CANCEL
    case CANCELLED
    case CUSTOM
    case ApprovedLowLimit
    case Refunded
    case RefundInProcess
    case RequestARefund
    case PartiallyRefunded
    case RequestAPartialRefund
    case PartialRefundInProcess
    case CancelledandMigrated
}

enum FinancialRequestStatus:Int,Codable{
    case UnderInvestigation
    case PendingCustomer
    case PartiallyPaid
    case WaitingForPayment
    case OnHold
    case Active
    case Rejected
    case Cancelled
    case ApprovedLowLimit
    case Refunded
    case RequestedARefund
    case RefundInProcess
    case WaitingFor2ndPaymentActivation
    case PendingActions
    case RequestedACancelled
}

enum ProviderTypeEnum: Int, Codable {
    case Doctor = 1
    case MedicalHistory
    case Insurance
    case GYM
    case Wedding
    case Others
    case Car
    case Finishing
    case School
    case UniversityOrInstitute
    case Course
    case Operation
    case Bill
    case Travel
}

//MARK: NEW FINANCIAL PROFILE
//MARK: OCR
enum OCRIMGENUM: String {
    case Front = "ocr.front"
    case Back = "ocr.back"
}

enum OCRUserType: String {
    case Client = "Client"
    case Guarantor = "Guarantor"
    case SalaryAdUser = "SalaryAdUser"
}

enum OCRDocumentType:String{
    case NationalID = "NationalID"
    case CarLicense = "CarLicense"
    case SalaryAdvance = "SalaryAdvance"
}
enum FinancialProfileSteps: Int,Codable{
    case One = 1
    case One_One
    case One_Two
    case Two
    case Three
    case Four
    case Five
    case Completed
    
}
enum FinancialCategoriesEnumNEW: Int,Codable {
    case BusinessOwner = 1
    case Salaried
    case Freelancer
    case Pension
    case AssetOwner
    case BankCertificate
    case MoneyTransfer
}
enum FinancialCategoriesEnumNEWAll: Int {
    case BusinessOwner = 1
    case Salaried
    case Freelancer
    case Pension
    case AssetOwner
    case BankCertificate
    case MoneyTransfer
    case MedicalInsurance
    case CarLicence
    case ClubMembership
}
enum FPWorkDuration: Int, Codable {
    case LessThanOneYear = 1
    case BetweenOneAndTwoYears
    case BetweenTwoAndFiveYears
    case MoreThanFiveYears
}
enum FinancialProfileStatus:Int,Codable{
    case New
    case Draft
    case ReadyToReview
    case UnderReview
    case Active
}
enum ActionStatus:Int,Codable {
    //    case New
    case Created = 1
    case NotSolved
    case Solved
    case Edit
    case Draft
}
enum FinancialAllCategoriesEnum: Int,Codable {
    case NationalSection = 1
    case GuarantorSection
    case GuarantorQuestion
    case CreditHistory
    case ConsumerFinance
    case BusinessOwner
    case Salaried
    case Freelancer
    case Pension
    case AssetOwner
    case BankCertificate
    case MoneyTransfer
    case MedicalInsurance
    case CarLicence
    case ClubMembership
    case generalCategory
}
enum FPsteps:Int,Codable{
    case BasicInfo = 1
    case CreditHistory
    case ProofOfIncome
    case FinancialInfo
    case UploadDocuments
}
enum FileType:Int,Codable{
    case Image = 1
    case PDF
    case Document
    case Audio
    case Other
}
enum AttachmentType:Int,Codable{
    case single = 1
    case multi
}

enum InstallmentProviderTypeEnum: Int, Codable {
    case Other = 0
    case Aman = 1
    case ValU
    case CreditCard
    case PremiumCard
    case Sympl
    case BankInstallment
    case Kiosk
    case Wallet
    case OneFinance
    case SkyFinance
    case Contact
}

enum InstallmentStatus:Int,Codable{
    case Paid
    case UnPaid
}

enum FinancialProfileSectionsEnum:Int,Codable {
    case Employees = 1
    case Pension
    case AssetsOwner
    case BusinessOwner
    case ClubMembership
    case BankCertificate
    case CreditAndLoans
    case CarOwner
    case ValuCustomer
    case FreeLancer
    case MedicalInsurance
    case MoneyTransfer
    case GeneralCategory
    case ConsumerFinance
    case PersonalInformation
    case GuarantorQuestions
    case GuarantorInformation
    case EmployeesAttachments
    case PensionAttachments
    case AssetsOwnerAttachments
    case BusinessOwnerAttachments
    case ClubMembershipAttachments
    case BankCertificateAttachments
    case CreditAndLoansAttachments
    case CarOwnerAttachments
    case FreeLancerAttachments
    case MedicalInsuranceAttachments
    case MoneyTransferAttachments
    case ConsumerFinanceAttachments
    
}

//MARK: Payments
enum PaymobPaymentStatus: Int, Codable {
    case Succeeded = 1
    case Pending
    case Declined
    case Active
}

enum PaymentStep: Int, Codable {
    case First = 1
    case Second
}


enum CheckoutActionsAfterSuccess:Int{
    case StartFP
    case CompleteFP
    case BasicInfo
    case Home
    case PaymentList
    case PayToFirstPayment
}

enum MedicalNetworkFrom: Int {
    case FromDoctor
    case FromHospital
    case FromFilter // add filter here as it happend scroll error
}

enum MedicalProviderList {
    case FromSubCategory
    case FromMoreDoctor
}

public enum ServiceTypeInstallmentEnum: Int,Codable{
    case Health = 1
    case Education
    case Insurance
    case GYM
    case Wedding
    case Others
    case Car
    case Finishing
    case Travel
    case BillPayment
}

//MARK: Error Messages
let ServerError = "We.are.sorry.something.went.wrong"
let NetworkError = "Please.check.your.internet.connection.and.try.again"
let requestCancelled = ""
//MARK: Alert Messages
let AlertServerErrorTitle = "Try.again"
let AlertNetworkErrorTitle = "No.Internet.Connection"
let AlertDataMessignTitle = "Data.Missing"
let AlertServerResponseTitle = "Alert.Alert.Title"
let AlertExpireTitle = "Your.session.was.expired"

//MARK: Padding TextFields
var paddingTxt: CGFloat = 5

//MARK: UserDefualts Const
let PATIENT_DATA = "patientUser"
let EDU_COURSE_CUSTOM_DATA = "CUSTOM_COURSE"
let EDU_SCHOOL_CUSTOM_DATA = "CUSTOM_SCHOOL"
let EDU_Univ_CUSTOM_DATA = "CUSTOM_UNIV"
let EDU_Inst_CUSTOM_DATA = "CUSTOM_INST"
