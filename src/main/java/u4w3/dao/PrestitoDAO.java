package u4w3.dao;

import u4w3.entities.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import u4w3.exception.ErroreGenericoException;
import u4w3.exception.ElementoNonTrovatoException;

import java.time.LocalDate;
import java.util.List;

public class PrestitoDAO {

    private final EntityManager em;

    public PrestitoDAO(EntityManager em) {
        this.em = em;
    }

    public void save(Prestito prestito) throws ErroreGenericoException {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(prestito);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new ErroreGenericoException("Errore durante il salvataggio del prestito: " + e.getMessage());
        }
    }

    public Prestito findById(Long id) throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            Prestito prestito = em.find(Prestito.class, id);
            if (prestito == null) {
                throw new ElementoNonTrovatoException("Nessun prestito trovato con ID: " + id);
            }
            return prestito;
        } catch (Exception e) {
            throw new ErroreGenericoException("Errore durante la ricerca del prestito per ID: " + e.getMessage());
        }
    }

    public List<Prestito> findAll() throws ErroreGenericoException {
        try {
            return em.createQuery("SELECT p FROM Prestito p", Prestito.class).getResultList();
        } catch (Exception e) {
            throw new ErroreGenericoException("Errore durante il recupero di tutti i prestiti: " + e.getMessage());
        }
    }

    public void delete(Prestito prestito) throws ErroreGenericoException, ElementoNonTrovatoException {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            if (prestito == null) {
                throw new ErroreGenericoException("Prestito non passato alla funzione di eliminazione");
            }
            if (em.find(Prestito.class, prestito.getId()) == null) {
                throw new ElementoNonTrovatoException("Prestito non trovato nel database");
            }
            em.remove(prestito);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new ErroreGenericoException("Errore durante l'eliminazione del prestito: " + e.getMessage());
        }
    }

    public List<Prestito> findByUtente(Utente utente) throws ErroreGenericoException {
        try {
            return em.createQuery("SELECT p FROM Prestito p WHERE p.utente = :utente", Prestito.class)
                    .setParameter("utente", utente)
                    .getResultList();
        } catch (Exception e) {
            throw new ErroreGenericoException("Errore durante la ricerca dei prestiti per utente: " + e.getMessage());
        }
    }

    public List<Prestito> findPrestitiScadutiNonRestituiti() throws ErroreGenericoException {
        try {
            LocalDate oggi = LocalDate.now();
            return em.createQuery(
                    "SELECT p FROM Prestito p WHERE p.dataRestituzionePrevista < :oggi AND p.dataRestituzioneEffettiva IS NULL",
                    Prestito.class)
                    .setParameter("oggi", oggi)
                    .getResultList();
        } catch (Exception e) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dei prestiti scaduti non restituiti: " + e.getMessage());
        }
    }

    // Prestiti per numero tessera
    public List<Prestito> findByNumeroTessera(String numeroTessera) throws ErroreGenericoException {
        try {
            return em
                    .createQuery("SELECT p FROM Prestito p WHERE p.utente.numeroTessera = :numeroTessera",
                            Prestito.class)
                    .setParameter("numeroTessera", numeroTessera)
                    .getResultList();
        } catch (Exception e) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dei prestiti per numero tessera: " + e.getMessage());
        }
    }
}